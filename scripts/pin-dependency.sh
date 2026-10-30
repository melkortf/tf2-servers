#!/usr/bin/env bash
#
# Pin a known upstream version of a dependency into a Dockerfile.
#
# Given a Dockerfile, the ARG prefix a dependency is pinned under, and a target
# upstream tag, this rewrites the pinned version, reconstructs each download URL
# from the ARG chain, downloads the asset(s), and rewrites every checksum. When
# the dependency carries a derived <PREFIX>_RELEASE_TAG (Metamod/SourceMod), that
# is updated too.
#
# Resolving *which* version to pin (a GitHub release, a human's input) and
# opening a pull request are the caller's job; this only pins a version it is
# handed. Portable across GNU (CI) and BSD/macOS coreutils.
#
# Usage:
#   pin-dependency.sh <dockerfile> <PREFIX> <tag>
#   pin-dependency.sh --dry-run <dockerfile> <PREFIX> <tag>
#   pin-dependency.sh --help
#
# Exit codes:
#   0   the Dockerfile was changed (or, with --dry-run, would change)
#   10  nothing changed: the tag is already pinned and checksums still match
#   1   usage error
#   2   the prefix is not pinned in the given Dockerfile
#   3   a download or checksum computation failed

set -euo pipefail

usage() {
  sed -n '3,25p' "$0" | sed 's/^# \{0,1\}//'
}

dry_run=false
case "${1:-}" in
  --help|-h) usage; exit 0 ;;
  --dry-run) dry_run=true; shift ;;
esac

if [ "$#" -ne 3 ]; then
  echo "error: expected <dockerfile> <PREFIX> <tag>" >&2
  usage >&2
  exit 1
fi

dockerfile=$1
prefix=$2
tag=$3

if [ ! -f "$dockerfile" ]; then
  echo "error: no such Dockerfile: $dockerfile" >&2
  exit 1
fi

# --- portable helpers --------------------------------------------------------

# get_arg <file> <NAME> -> prints the value of `ARG NAME=<value>` (first match)
get_arg() {
  sed -n "s|^ARG $2=\\(.*\\)|\\1|p" "$1" | head -n1
}

# set_arg <file> <NAME> <VALUE> -> rewrites `ARG NAME=...` in place (atomic)
set_arg() {
  local tmp
  tmp=$(mktemp)
  sed "s|^ARG $2=.*|ARG $2=$3|" "$1" > "$tmp"
  mv "$tmp" "$1"
}

# has_arg <file> <NAME> -> succeeds if `ARG NAME=` is present
has_arg() {
  grep -q "^ARG $2=" "$1"
}

sha256() {
  if command -v sha256sum >/dev/null 2>&1; then
    sha256sum "$1" | awk '{print $1}'
  else
    shasum -a 256 "$1" | awk '{print $1}'
  fi
}

# normalize <tag> <current> -> tag matching the file's leading-"v" convention
normalize() {
  local tag=$1 current=$2
  if [ "${current#v}" != "$current" ]; then
    case "$tag" in v*) printf '%s' "$tag" ;; *) printf 'v%s' "$tag" ;; esac
  else
    printf '%s' "${tag#v}"
  fi
}

# reconstruct_urls <file> <prefix> -> prints "URL_ARG_NAME<TAB>resolved-url" lines.
# Evaluates the prefix's ARG chain in file order so <PREFIX>_URL expands against
# the already-updated <PREFIX>_VERSION. Inputs are our own first-party Dockerfiles.
reconstruct_urls() {
  local file=$1 prefix=$2 defs names
  defs=$(sed -n "s|^ARG[[:space:]][[:space:]]*\\(${prefix}[A-Z0-9_]*\\)=\\(.*\\)|\\1=\"\\2\"|p" "$file")
  names=$(sed -n "s|^ARG[[:space:]][[:space:]]*\\(${prefix}[A-Z0-9_]*_URL\\)=.*|\\1|p" "$file")
  (
    eval "$defs"
    for n in $names; do
      eval "printf '%s\\t%s\\n' \"$n\" \"\$$n\""
    done
  )
}

# --- pin ---------------------------------------------------------------------

if ! has_arg "$dockerfile" "${prefix}_VERSION"; then
  echo "error: ${prefix}_VERSION is not pinned in $dockerfile" >&2
  exit 2
fi

current=$(get_arg "$dockerfile" "${prefix}_VERSION")
target=$(normalize "$tag" "$current")

work=$(mktemp)
trap 'rm -f "$work"' EXIT
cp "$dockerfile" "$work"

set_arg "$work" "${prefix}_VERSION" "$target"
if has_arg "$work" "${prefix}_RELEASE_TAG"; then
  set_arg "$work" "${prefix}_RELEASE_TAG" "${target/-git/.}"
fi

while IFS=$(printf '\t') read -r url_arg url; do
  [ -n "$url_arg" ] || continue
  checksum_arg="${url_arg%_URL}_CHECKSUM"
  asset=$(mktemp)
  if ! curl --fail --location --silent "$url" --output "$asset"; then
    echo "error: failed to download $url" >&2
    rm -f "$asset"
    exit 3
  fi
  checksum=$(sha256 "$asset")
  rm -f "$asset"
  if [ -z "$checksum" ]; then
    echo "error: failed to compute checksum for $url" >&2
    exit 3
  fi
  echo "  ${checksum_arg}=${checksum}  <- ${url}" >&2
  set_arg "$work" "$checksum_arg" "$checksum"
done <<EOF
$(reconstruct_urls "$work" "$prefix")
EOF

if cmp -s "$work" "$dockerfile"; then
  echo "unchanged: ${prefix} already pinned to ${target} in ${dockerfile}" >&2
  exit 10
fi

if [ "$dry_run" = true ]; then
  echo "would update ${prefix} -> ${target} in ${dockerfile}:" >&2
  diff "$dockerfile" "$work" || true
  exit 0
fi

cp "$work" "$dockerfile"
echo "updated ${prefix} -> ${target} in ${dockerfile}" >&2
exit 0

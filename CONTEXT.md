# Domain glossary

Names for the concepts this repo is built around. Keep terms here in sync with
the code that uses them.

## Dependency pin

A single upstream artifact (a plugin, a config bundle, a shared library) frozen
into a Dockerfile as a block of `ARG <PREFIX>_*` lines: `_VERSION`, `_FILE_NAME`,
`_URL`, `_CHECKSUM`, and — for Metamod/SourceMod — a derived `_RELEASE_TAG`. The
`<PREFIX>` is the pin's key; the `_URL` is reconstructed from the ARG chain so it
tracks `_VERSION` automatically. Some pins carry more than one artifact under one
version (e.g. `SRCTV_PLUS` has an SO and a VDF, each with its own `_CHECKSUM`).

`scripts/pin-dependency.sh` is the one module that reads and rewrites a pin: hand
it a Dockerfile, a `<PREFIX>`, and a target tag and it normalizes the version,
reconstructs each URL, refreshes each checksum, and reports changed / unchanged.
Resolving *which* version to pin, and opening a PR, live outside it.

## Version resolution (the seam above pin-dependency)

Deciding the target version a pin should move to. Two adapters over the same pin
operation:

- **scan** (`scan-plugin-updates.yml`): resolves the latest GitHub release
  automatically, on a schedule, for pins hosted as proper GitHub releases.
- **update-package** (`update-package.yml`): takes a human-supplied version, for
  pins on moving refs, non-GitHub hosts, or bespoke versioning (Metamod/SourceMod
  snapshots) that scan intentionally leaves alone.

Both resolve a version, then call `pin-dependency.sh`, then open a PR only when it
reports a change.

#!/bin/bash

auto_envsubst() {
  local template_dir="${SERVER_DIR}/tf/cfg"
  local suffix=".template"

  find "$template_dir" -follow -type f -name "*$suffix" -print | while read -r template; do
    output_file="${template%$suffix}"
    envsubst < "${template}" > "${output_file}"
  done
}

faketty() {
  # https://stackoverflow.com/questions/1401002/how-to-trick-an-application-into-thinking-its-stdout-is-a-terminal-not-a-pipe/60279429#60279429
  tmp=$(mktemp)
  [ "$tmp" ] || return 99
  cmd="$(printf '%q ' "$@")"'; echo $? > '$tmp
  script -qfc "/bin/sh -c $(printf "%q " "$cmd")" /dev/null
  [ -s $tmp ] || return 99
  err=$(cat $tmp)
  rm -f $tmp
  return $err
}

quit() {
  echo "*** Stopping ***"
  "${SERVER_DIR}/rcon" -H ${IP/0.0.0.0/127.0.0.1} -p ${PORT} -P ${RCON_PASSWORD} quit
  sleep 5
  exit 0
}

trap 'quit' SIGTERM

auto_envsubst

faketty $SERVER_DIR/srcds_run \
  -game tf \
  -secured \
  -steam_dir ${HOME}/.steam/steamcmd \
  -steamcmd_script ${HOME}/tf2.txt \
  -autoupdate \
  -ip ${IP} \
  -port ${PORT} \
  +clientport ${CLIENT_PORT} \
  -steamport ${STEAM_PORT} \
  +tv_port ${STV_PORT} \
  -strictportbind \
  -norestart \
  $@ & wait ${!}

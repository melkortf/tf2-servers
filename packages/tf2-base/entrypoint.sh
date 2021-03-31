#!/bin/bash

auto_envsubst() {
  local template_dir="${SERVER_DIR}/tf/cfg"
  local suffix=".template"

  find "$template_dir" -follow -type f -name "*$suffix" -print | while read -r template; do
    output_file="${template%$suffix}"
    envsubst < "${template}" > "${output_file}"
  done
}

auto_envsubst


$SERVER_DIR/srcds_run \
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
  $@

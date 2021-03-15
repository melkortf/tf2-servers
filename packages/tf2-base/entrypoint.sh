#!/bin/bash

./generate_dynamic_cfg.sh > $SERVER_DIR/tf/cfg/server_dynamic.cfg

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

#!/bin/bash

status="$("${SERVER_DIR}/rcon" -H ${IP/0.0.0.0/127.0.0.1} -p ${PORT} -P ${RCON_PASSWORD} status)" || exit $?

# extract hostname
if [[ $status =~ hostname:[[:space:]](.+)[[:space:]]version[[:space:]]:[[:space:]] ]]; then
  echo "hostname: ${BASH_REMATCH[1]}"
fi

# extract map
if [[ $status =~ map[[:space:]]+:[[:space:]]([a-zA-Z0-9_]+) ]]; then
  echo "map: ${BASH_REMATCH[1]}"
fi

# extract player count
if [[ $status =~ players[[:space:]]:[[:space:]]([0-9]+)[[:space:]]humans,[[:space:]][0-9]+[[:space:]]bots[[:space:]]\(([0-9]+)[[:space:]]max\) ]]; then
  echo "players: ${BASH_REMATCH[1]}/${BASH_REMATCH[2]}"
fi

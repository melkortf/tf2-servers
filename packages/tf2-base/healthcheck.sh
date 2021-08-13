#!/bin/bash

"${SERVER_DIR}/rcon" -H 127.0.0.1 -p ${PORT} -P ${RCON_PASSWORD} status

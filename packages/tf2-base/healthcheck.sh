#!/bin/bash

"${SERVER_DIR}/rcon" -H ${IP/0.0.0.0/127.0.0.1} -p ${PORT} -P ${RCON_PASSWORD} status

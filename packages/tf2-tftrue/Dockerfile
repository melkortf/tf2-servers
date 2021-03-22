FROM melkortf/tf2-sourcemod:latest
LABEL maintainer="garrappachc@gmail.com"

WORKDIR $SERVER_DIR/tf

ARG TFTRUE_FILE_NAME=tftrue4_79.zip
ARG TFTRUE_URL=https://sappho.io/files/tf/${TFTRUE_FILE_NAME}

RUN wget -nv "${TFTRUE_URL}" \
  && unzip "${TFTRUE_FILE_NAME}" \
  && rm -f "${TFTRUE_FILE_NAME}"

WORKDIR $SERVER_DIR
CMD ["+sv_pure", "2", "+map", "cp_badlands", "+maxplayers", "24"]

ENV LOGS_TF_APIKEY=
ENV LOGS_TF_PREFIX=

COPY server.cfg.template ${SERVER_DIR}/tf/cfg/server.cfg.template

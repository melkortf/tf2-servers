FROM melkortf/tf2-sourcemod:latest
LABEL maintainer="garrappachc@gmail.com"

ARG TFTRUE_FILE_NAME=TFTrue.zip
ARG TFTRUE_URL=https://tftrue.esport-tools.net/${TFTRUE_FILE_NAME}

RUN wget -nv --no-check-certificate "${TFTRUE_URL}" \
  && unzip "${TFTRUE_FILE_NAME}" -d "${SERVER_DIR}/tf/" \
  && rm -f "${TFTRUE_FILE_NAME}"

RUN wget -nv "https://melkor.tf/TFTrue.so" -O "${SERVER_DIR}/tf/addons/TFTrue.so"

CMD ["+sv_pure", "2", "+map", "cp_badlands", "+maxplayers", "24"]

ENV LOGS_TF_APIKEY=
ENV LOGS_TF_PREFIX=

COPY server.cfg.template ${SERVER_DIR}/tf/cfg/server.cfg.template

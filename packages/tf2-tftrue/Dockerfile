FROM melkortf/tf2-sourcemod:latest
LABEL maintainer="garrappachc@gmail.com"

ARG TFTRUE_FILE_NAME=TFTrue.so
ARG TFTRUE_URL=https://raw.githubusercontent.com/AnAkkk/TFTrue/public/release/${TFTRUE_FILE_NAME}

RUN wget -nv "${TFTRUE_URL}" -P "${SERVER_DIR}/tf/addons/" \
  && rm -f "${TFTRUE_FILE_NAME}"

CMD ["+sv_pure", "2", "+map", "cp_badlands", "+maxplayers", "24"]

ENV LOGS_TF_APIKEY=
ENV LOGS_TF_PREFIX=

COPY server.cfg.template ${SERVER_DIR}/tf/cfg/server.cfg.template

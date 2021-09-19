FROM melkortf/tf2-sourcemod:latest
LABEL maintainer="garrappachc@gmail.com"

ARG TFTRUE_URL=https://github.com/AnAkkk/TFTrue/raw/public/release/TFTrue.so

COPY TFTrue.vdf "${SERVER_DIR}/tf/addons/TFTrue.vdf"
RUN wget -nv "${TFTRUE_URL}" -O "${SERVER_DIR}/tf/addons/TFTrue.so"

CMD ["+sv_pure", "2", "+map", "cp_badlands", "+maxplayers", "24"]

ENV LOGS_TF_APIKEY=
ENV LOGS_TF_PREFIX=

COPY server.cfg.template ${SERVER_DIR}/tf/cfg/server.cfg.template

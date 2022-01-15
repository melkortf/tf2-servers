FROM melkortf/tf2-sourcemod:latest
LABEL maintainer="garrappachc@gmail.com"

ARG TFTRUE_URL=https://github.com/AnAkkk/TFTrue/raw/1867de3cf3dd77afdef6ee4c3929f6e94772cb35/release/TFTrue.so

COPY TFTrue.vdf "${SERVER_DIR}/tf/addons/TFTrue.vdf"
COPY checksum.md5 .
RUN wget -nv "${TFTRUE_URL}" -O TFTrue.so \
  && md5sum -c checksum.md5 \
  && mv TFTrue.so "${SERVER_DIR}/tf/addons/TFTrue.so" \
  && rm checksum.md5

CMD ["+sv_pure", "2", "+map", "cp_badlands", "+maxplayers", "24"]

ENV LOGS_TF_APIKEY=
ENV LOGS_TF_PREFIX=

COPY server.cfg.template ${SERVER_DIR}/tf/cfg/server.cfg.template

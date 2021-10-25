FROM melkortf/tf2-sourcemod:latest
LABEL maintainer="garrappachc@gmail.com"

ARG TFTRUE_VERSION=4.85
ARG TFTRUE_URL=https://github.com/AnAkkk/TFTrue/archive/refs/tags/${TFTRUE_VERSION}.zip

COPY TFTrue.vdf "${SERVER_DIR}/tf/addons/TFTrue.vdf"
COPY checksum.md5 .
RUN wget -nv "${TFTRUE_URL}" -O TFTrue.zip \
  && unzip -p TFTrue.zip "TFTrue-${TFTRUE_VERSION}/release/TFTrue.so" > TFTrue.so \
  && md5sum -c checksum.md5 \
  && cp TFTrue.so "${SERVER_DIR}/tf/addons/TFTrue.so" \
  && rm checksum.md5 \
  && rm TFTrue.zip

CMD ["+sv_pure", "2", "+map", "cp_badlands", "+maxplayers", "24"]

ENV LOGS_TF_APIKEY=
ENV LOGS_TF_PREFIX=

COPY server.cfg.template ${SERVER_DIR}/tf/cfg/server.cfg.template

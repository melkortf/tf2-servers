FROM debian:latest AS tftrue-build
WORKDIR /build

ARG TFTRUE_REPOSITORY_URL=https://github.com/AnAkkk/TFTrue.git
ARG TFTRUE_COMMIT=f5d866fcd5e6d27992b888919484a7b1a3f24454

RUN apt-get -y update \
  && apt-get install -y build-essential git cmake gcc-multilib g++-multilib \
  && rm -rf /var/lib/apt/lists/* \
  && git clone --recurse-submodules ${TFTRUE_REPOSITORY_URL} tftrue \
  && cd tftrue \
  && git checkout ${TFTRUE_COMMIT} \
  && mkdir build \
  && cd build \
  && env CXXFLAGS="-DNO_AUTOUPDATE" cmake .. -DCMAKE_BUILD_TYPE=Release \
  && make


ARG TF2_SOURCEMOD_TAG=latest
FROM melkortf/tf2-sourcemod:${TF2_SOURCEMOD_TAG}
LABEL maintainer="garrappachc@gmail.com"

COPY TFTrue.vdf "${SERVER_DIR}/tf/addons/TFTrue.vdf"
COPY --from=tftrue-build /build/tftrue/build/TFTrue.so ${SERVER_DIR}/tf/addons/TFTrue.so

CMD ["+sv_pure", "2", "+map", "cp_badlands", "+maxplayers", "24"]

ENV LOGS_TF_APIKEY=
ENV LOGS_TF_PREFIX=

COPY server.cfg.template ${SERVER_DIR}/tf/cfg/server.cfg.template

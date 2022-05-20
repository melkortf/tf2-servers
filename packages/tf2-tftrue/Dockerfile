FROM debian:latest AS tftruer-build
WORKDIR /build

ARG TFTRUER_REPOSITORY_URL=https://github.com/sapphonie/TFTruer.git
ARG TFTRUER_COMMIT=e83c8bbba3f80859a7cab5191d7232b2ea357869

RUN apt-get -y update \
  && apt-get install -y build-essential git cmake gcc-multilib g++-multilib \
  && rm -rf /var/lib/apt/lists/* \
  && git clone --recurse-submodules ${TFTRUER_REPOSITORY_URL} tftruer \
  && cd tftruer \
  && git checkout ${TFTRUER_COMMIT} \
  && mkdir build \
  && cd build \
  && env CXXFLAGS="-DNO_AUTOUPDATE" cmake .. -DCMAKE_BUILD_TYPE=Release \
  && make


FROM melkortf/tf2-sourcemod:latest
LABEL maintainer="garrappachc@gmail.com"

COPY tftruer.vdf "${SERVER_DIR}/tf/addons/tftruer.vdf"
COPY --from=tftruer-build /build/tftruer/build/tftruer.so ${SERVER_DIR}/tf/addons/tftruer.so

CMD ["+sv_pure", "2", "+map", "cp_badlands", "+maxplayers", "24"]

ENV LOGS_TF_APIKEY=
ENV LOGS_TF_PREFIX=

COPY server.cfg.template ${SERVER_DIR}/tf/cfg/server.cfg.template

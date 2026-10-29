ARG REGISTRY=ghcr.io
ARG TF2_SOURCEMOD_TAG=latest

FROM ubuntu:26.04 AS plugins
RUN export DEBIAN_FRONTEND=noninteractive \
  && export TZ=Etc/UTC \
  && apt-get -y update \
  && apt-get install -y --no-install-recommends --no-install-suggests \
  unzip \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /download
ARG PLUGIN_INSTALL_DIR=/server/tf
RUN mkdir -p "${PLUGIN_INSTALL_DIR}"

ARG MGEMOD_FILE_NAME=mge.zip
ARG MGEMOD_VERSION=v3.1.0-beta42
ARG MGEMOD_URL=https://github.com/mgetf/MGEMod/releases/download/${MGEMOD_VERSION}/${MGEMOD_FILE_NAME}
ARG MGEMOD_CHECKSUM=e9fb48dcc4b05046818424fa6013a1fdf214e49d8aef5aff441b412da9e76aef
ADD --checksum=sha256:${MGEMOD_CHECKSUM} ${MGEMOD_URL} .
RUN unzip -q -n "${MGEMOD_FILE_NAME}" -d "${PLUGIN_INSTALL_DIR}/"

ARG SOURCEBANS_VERSION=2.2.3
ARG SOURCEBANS_FILE_NAME=sourcebans-pp-${SOURCEBANS_VERSION}.plugin-only.tar.gz
ARG SOURCEBANS_URL=https://github.com/sbpp/sourcebans-pp/releases/download/${SOURCEBANS_VERSION}/${SOURCEBANS_FILE_NAME}
ARG SOURCEBANS_CHECKSUM=13d504ceaaddcb8ba427bdc8e4e53a6b58ec81f26e536c661587c21883a48acc
ADD --checksum=sha256:${SOURCEBANS_CHECKSUM} ${SOURCEBANS_URL} .
RUN tar xf "${SOURCEBANS_FILE_NAME}" -C "${PLUGIN_INSTALL_DIR}/"

# vendored: sourcemod.net blocks downloads from GitHub Actions runners
COPY afk_manager4.smx "${PLUGIN_INSTALL_DIR}/addons/sourcemod/plugins/"

FROM ${REGISTRY}/melkortf/tf2-sourcemod/i386:${TF2_SOURCEMOD_TAG}
LABEL maintainer="garrappachc@gmail.com"

ARG PLUGIN_INSTALL_DIR=/server/tf
COPY --from=plugins --chown=tf2 "${PLUGIN_INSTALL_DIR}/" "${SERVER_DIR}/tf/"

RUN mv "${SERVER_DIR}/tf/addons/sourcemod/plugins/"{funcommands,funvotes}.smx "${SERVER_DIR}/tf/addons/sourcemod/plugins/disabled/"

ENV SELECTED_MAP="mge_training_v8_beta4b"

COPY server.cfg.template "${SERVER_DIR}/tf/cfg/server.cfg.template"
COPY mapcycle.txt.template "${SERVER_DIR}/tf/cfg/mapcycle.txt.template"
COPY afk_manager.cfg "${SERVER_DIR}/tf/cfg/sourcemod/afk_manager.cfg"
COPY afk_manager.phrases.txt "${SERVER_DIR}/tf/addons/sourcemod/translations/afk_manager.phrases.txt"

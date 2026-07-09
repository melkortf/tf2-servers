ARG REGISTRY=ghcr.io
ARG TF2_SOURCEMOD_TAG=latest

FROM ubuntu:22.04 AS plugins
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
ARG MGEMOD_VERSION=v3.0.9
ARG MGEMOD_URL=https://github.com/sapphonie/MGEMod/releases/download/${MGEMOD_VERSION}/${MGEMOD_FILE_NAME}
ARG MGEMOD_CHECKSUM=170769cd4ae2ec627dce26b655fba92a358c643b8c258094b4b087bb8b3d1a56
ADD --checksum=sha256:${MGEMOD_CHECKSUM} ${MGEMOD_URL} .
RUN unzip -q -n "${MGEMOD_FILE_NAME}" -d "${PLUGIN_INSTALL_DIR}/"

ARG SOURCEBANS_VERSION=2.0.0
ARG SOURCEBANS_FILE_NAME=sourcebans-pp-${SOURCEBANS_VERSION}.plugin-only.tar.gz
ARG SOURCEBANS_URL=https://github.com/sbpp/sourcebans-pp/releases/download/${SOURCEBANS_VERSION}/${SOURCEBANS_FILE_NAME}
ARG SOURCEBANS_CHECKSUM=b5ce9c417c6c6efde01a1850114d3eb7ef8aec1f52e088a5382d5aa0cd85ca39
ADD --checksum=sha256:${SOURCEBANS_CHECKSUM} ${SOURCEBANS_URL} .
RUN tar xf "${SOURCEBANS_FILE_NAME}" -C "${PLUGIN_INSTALL_DIR}/"

ARG AFK_MANAGER_FILE_NAME=afk_manager4.smx
ARG AFK_MANAGER_URL=https://www.sourcemod.net/vbcompiler.php?file_id=170330
ARG AFK_MANAGER_CHECKSUM=cd41cf4195f8e54c579ed4fe730457a5c81f8007478ff9cd75b9659f8859c22b
ADD --checksum=sha256:${AFK_MANAGER_CHECKSUM} ${AFK_MANAGER_URL} "${PLUGIN_INSTALL_DIR}/addons/sourcemod/plugins/${AFK_MANAGER_FILE_NAME}"

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

ARG REGISTRY=ghcr.io
ARG TF2_SOURCEMOD_TAG=latest

FROM ubuntu:22.04 AS plugins
SHELL ["/bin/bash", "-c"]
RUN export DEBIAN_FRONTEND=noninteractive \
  && export TZ=Etc/UTC \
  && apt-get -y update \
  && apt-get install -y --no-install-recommends --no-install-suggests \
  unzip \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /download
ARG PLUGIN_INSTALL_DIR=/server/tf
RUN mkdir -p "${PLUGIN_INSTALL_DIR}"

ARG SOAP_DM_FILE_NAME=soap.zip
ARG SOAP_DM_VERSION=4.4.7
ARG SOAP_DM_URL=https://github.com/sapphonie/SOAP-TF2DM/releases/download/v${SOAP_DM_VERSION}/${SOAP_DM_FILE_NAME}
ARG SOAP_DM_CHECKSUM=1d9f15dd9899057eaff43ea7b50976b119db94a89f1e678c19839785f49eae43
ADD --checksum=sha256:${SOAP_DM_CHECKSUM} ${SOAP_DM_URL} .
RUN unzip -q "${SOAP_DM_FILE_NAME}" -d "${PLUGIN_INSTALL_DIR}/"

ARG COMP_FIXES_FILE_NAME=tf2-comp-fixes.zip
ARG COMP_FIXES_VERSION=1.16.14
ARG COMP_FIXES_URL=https://github.com/ldesgoui/tf2-comp-fixes/releases/download/v${COMP_FIXES_VERSION}/${COMP_FIXES_FILE_NAME}
ARG COMP_FIXES_CHECKSUM=1cde2675f51617410d189e839a95d91d3347d8c0904bd1eeec843ef6877c9c92
ADD --checksum=sha256:${COMP_FIXES_CHECKSUM} ${COMP_FIXES_URL} .
RUN unzip -q -o "${COMP_FIXES_FILE_NAME}" -d "${PLUGIN_INSTALL_DIR}/"

ARG SOURCEBANS_VERSION=1.6.4
ARG SOURCEBANS_FILE_NAME=sourcebans-pp-${SOURCEBANS_VERSION}.plugin-only.tar.gz
ARG SOURCEBANS_URL=https://github.com/sbpp/sourcebans-pp/releases/download/${SOURCEBANS_VERSION}/${SOURCEBANS_FILE_NAME}
ARG SOURCEBANS_CHECKSUM=f949fcb3f0dc37e39b6d2257ba902a1d67d49b854b46d6f7a061a76e6b7994b1
ADD --checksum=sha256:${SOURCEBANS_CHECKSUM} ${SOURCEBANS_URL} .
RUN tar xf "${SOURCEBANS_FILE_NAME}" -C "${PLUGIN_INSTALL_DIR}/"

ARG TF2RUE_FILE_NAME=tf2rue.zip
ARG TF2RUE_VERSION=v0.0.12
ARG TF2RUE_URL=https://github.com/sapphonie/tf2rue/releases/download/${TF2RUE_VERSION}/${TF2RUE_FILE_NAME}
ARG TF2RUE_CHECKSUM=58add29f81f4b4c98a0ef1ef07d68e8e348556936284da8bbdec8ddcab3bda71
ADD --checksum=sha256:${TF2RUE_CHECKSUM} ${TF2RUE_URL} .
RUN unzip -q -n "${TF2RUE_FILE_NAME}" -d "${PLUGIN_INSTALL_DIR}/addons/sourcemod/"

ARG AFK_MANAGER_FILE_NAME=afk_manager4.smx
ARG AFK_MANAGER_URL=https://www.sourcemod.net/vbcompiler.php?file_id=170330
ARG AFK_MANAGER_CHECKSUM=cd41cf4195f8e54c579ed4fe730457a5c81f8007478ff9cd75b9659f8859c22b
ADD --checksum=sha256:${AFK_MANAGER_CHECKSUM} ${AFK_MANAGER_URL} "${PLUGIN_INSTALL_DIR}/addons/sourcemod/plugins/${AFK_MANAGER_FILE_NAME}"

ARG CLASS_RESTRICT_FILE_NAME=classrestrict.smx
ARG CLASS_RESTRICT_URL=https://www.sourcemod.net/vbcompiler.php?file_id=27957
ARG CLASS_RESTRICT_CHECKSUM=bce83fef7c80f66f0d1a102433aebdd5201d8ef2e3e5ea4442d1fe30f84938e9
ADD --checksum=sha256:${CLASS_RESTRICT_CHECKSUM} ${CLASS_RESTRICT_URL} "${PLUGIN_INSTALL_DIR}/addons/sourcemod/plugins/${CLASS_RESTRICT_FILE_NAME}"

FROM ${REGISTRY}/melkortf/tf2-sourcemod/i386:${TF2_SOURCEMOD_TAG}
LABEL maintainer="garrappachc@gmail.com"

ARG PLUGIN_INSTALL_DIR=/server/tf
COPY --from=plugins --chown=tf2 "${PLUGIN_INSTALL_DIR}/" "${SERVER_DIR}/tf/"

RUN mv "${SERVER_DIR}/tf/addons/sourcemod/plugins/"{funcommands,funvotes}.smx "${SERVER_DIR}/tf/addons/sourcemod/plugins/disabled/"

COPY server.cfg.template "${SERVER_DIR}/tf/cfg/server.cfg.template"
COPY soap_tf2dm.cfg "${SERVER_DIR}/tf/cfg/sourcemod/soap_tf2dm.cfg"
COPY mapcycle.txt "${SERVER_DIR}/tf/cfg/mapcycle.txt"
COPY afk_manager.cfg "${SERVER_DIR}/tf/cfg/sourcemod/afk_manager.cfg"
COPY custom_whitelist_11769.txt "${SERVER_DIR}/tf/cfg/custom_whitelist_11769.txt"
COPY afk_manager.phrases.txt "${SERVER_DIR}/tf/addons/sourcemod/translations/afk_manager.phrases.txt"

CMD ["+sv_pure", "2", "+map", "cp_badlands", "+maxplayers", "8"]

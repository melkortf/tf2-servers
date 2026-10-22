ARG REGISTRY=ghcr.io
ARG TF2_SOURCEMOD_TAG=latest

FROM ubuntu:26.04 AS plugins
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
ARG SOAP_DM_VERSION=4.4.9
ARG SOAP_DM_URL=https://github.com/sapphonie/SOAP-TF2DM/releases/download/v${SOAP_DM_VERSION}/${SOAP_DM_FILE_NAME}
ARG SOAP_DM_CHECKSUM=aee4474a3528087241bcd4d61b1a99feaf2fb0a942b41f7ca0c887eef61a624e
ADD --checksum=sha256:${SOAP_DM_CHECKSUM} ${SOAP_DM_URL} .
RUN unzip -q "${SOAP_DM_FILE_NAME}" -d "${PLUGIN_INSTALL_DIR}/"

ARG COMP_FIXES_FILE_NAME=tf2-comp-fixes.zip
ARG COMP_FIXES_VERSION=1.18.1
ARG COMP_FIXES_URL=https://github.com/ldesgoui/tf2-comp-fixes/releases/download/v${COMP_FIXES_VERSION}/${COMP_FIXES_FILE_NAME}
ARG COMP_FIXES_CHECKSUM=781cc48e13aa896f4856fa80d78a6aaaffc221c20e7fa627c40ddc9cc71c3614
ADD --checksum=sha256:${COMP_FIXES_CHECKSUM} ${COMP_FIXES_URL} .
RUN unzip -q -o "${COMP_FIXES_FILE_NAME}" -d "${PLUGIN_INSTALL_DIR}/"

ARG SOURCEBANS_VERSION=2.2.2
ARG SOURCEBANS_FILE_NAME=sourcebans-pp-${SOURCEBANS_VERSION}.plugin-only.tar.gz
ARG SOURCEBANS_URL=https://github.com/sbpp/sourcebans-pp/releases/download/${SOURCEBANS_VERSION}/${SOURCEBANS_FILE_NAME}
ARG SOURCEBANS_CHECKSUM=782f15557c9fcec0a9445ae981e05e4af0f7ea92da5a1df49f1951137ee5a557
ADD --checksum=sha256:${SOURCEBANS_CHECKSUM} ${SOURCEBANS_URL} .
RUN tar xf "${SOURCEBANS_FILE_NAME}" -C "${PLUGIN_INSTALL_DIR}/"

ARG TF2RUE_FILE_NAME=tf2rue.zip
ARG TF2RUE_VERSION=v0.0.13
ARG TF2RUE_URL=https://github.com/sapphonie/tf2rue/releases/download/${TF2RUE_VERSION}/${TF2RUE_FILE_NAME}
ARG TF2RUE_CHECKSUM=670f228f287bb55c4418ff8241032582189621a944a420f42ddae9db6754b6cd
ADD --checksum=sha256:${TF2RUE_CHECKSUM} ${TF2RUE_URL} .
RUN unzip -q -n "${TF2RUE_FILE_NAME}" -d "${PLUGIN_INSTALL_DIR}/addons/sourcemod/"

# vendored: sourcemod.net blocks downloads from GitHub Actions runners
COPY afk_manager4.smx classrestrict.smx "${PLUGIN_INSTALL_DIR}/addons/sourcemod/plugins/"

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

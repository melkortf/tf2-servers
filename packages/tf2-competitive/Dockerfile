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

ARG MGEMOD_FILE_NAME=mge.zip
ARG MGEMOD_VERSION=v3.0.9
ARG MGEMOD_URL=https://github.com/sapphonie/MGEMod/releases/download/${MGEMOD_VERSION}/${MGEMOD_FILE_NAME}
ARG MGEMOD_CHECKSUM=170769cd4ae2ec627dce26b655fba92a358c643b8c258094b4b087bb8b3d1a56
ADD --checksum=sha256:${MGEMOD_CHECKSUM} ${MGEMOD_URL} .
RUN unzip -q -n "${MGEMOD_FILE_NAME}" -d "${PLUGIN_INSTALL_DIR}/"

ARG NEOCURL_FILE_NAME=sm-neocurl-repack.zip
ARG NEOCURL_VERSION=v2.0.1-beta1
ARG NEOCURL_URL=https://github.com/sapphonie/SM-neocurl-ext/releases/download/${NEOCURL_VERSION}/${NEOCURL_FILE_NAME}
ARG NEOCURL_CHECKSUM=cddbef00ca5b4b2a14c35fd062fe18586fb42f68c6d6366bf74f5b72a5734e44
ADD --checksum=sha256:${NEOCURL_CHECKSUM} ${NEOCURL_URL} .
RUN unzip -q -o "${NEOCURL_FILE_NAME}" -d "${PLUGIN_INSTALL_DIR}/addons/sourcemod/"

ARG F2_SOURCEMOD_PLUGINS_FILE_NAME=f2-sourcemod-plugins.zip
ARG F2_SOURCEMOD_PLUGINS_VERSION=20260523-1779572117109
ARG F2_SOURCEMOD_PLUGINS_URL=https://github.com/F2/F2s-sourcemod-plugins/releases/download/${F2_SOURCEMOD_PLUGINS_VERSION}/${F2_SOURCEMOD_PLUGINS_FILE_NAME}
ARG F2_SOURCEMOD_PLUGINS_CHECKSUM=169428e2114906cb228e38b93b695981492386591d435c833e4dc13b42c0b761
ADD --checksum=sha256:${F2_SOURCEMOD_PLUGINS_CHECKSUM} ${F2_SOURCEMOD_PLUGINS_URL} .
ARG F2_ENABLED_PLUGINS="afk.smx fixstvslot.smx logstf.smx medicstats.smx recordstv.smx restorescore.smx supstats2.smx waitforstv.smx"
RUN unzip -q -j "${F2_SOURCEMOD_PLUGINS_FILE_NAME}" ${F2_ENABLED_PLUGINS} \
  -d "${PLUGIN_INSTALL_DIR}/addons/sourcemod/plugins/"

ARG ETF2L_CONFIGS_FILE_NAME=etf2l_configs.zip
ARG ETF2L_CONFIGS_VERSION=1.0.26
ARG ETF2L_CONFIGS_URL=https://github.com/ETF2L/gameserver-configs/releases/download/${ETF2L_CONFIGS_VERSION}/${ETF2L_CONFIGS_FILE_NAME}
ARG ETF2L_CONFIGS_CHECKSUM=0ced7067056d20f2986a3a1310968a3ad29ef77a39000661c684a4739b51e62e
ADD --checksum=sha256:${ETF2L_CONFIGS_CHECKSUM} ${ETF2L_CONFIGS_URL} .
RUN unzip -q "${ETF2L_CONFIGS_FILE_NAME}" -d "${PLUGIN_INSTALL_DIR}/cfg/"

ARG RGL_CONFIGS_FILE_NAME=server-resources-updater.zip
ARG RGL_CONFIGS_VERSION=v372
ARG RGL_CONFIGS_URL=https://github.com/RGLgg/server-resources-updater/releases/download/${RGL_CONFIGS_VERSION}/${RGL_CONFIGS_FILE_NAME}
ARG RGL_CONFIGS_CHECKSUM=94f2630801e0df9e34eaaf99743642bc1627a3021516b2c1f98b0f006a885e49
ADD --checksum=sha256:${RGL_CONFIGS_CHECKSUM} ${RGL_CONFIGS_URL} .
RUN unzip -q "${RGL_CONFIGS_FILE_NAME}" \
  && cp "cfg/"* "${PLUGIN_INSTALL_DIR}/cfg/" \
  && cp "addons/sourcemod/plugins/"{config_checker,rglqol}.smx "${PLUGIN_INSTALL_DIR}/addons/sourcemod/plugins/" \
  && cp "addons/sourcemod/scripting/"{config_checker,rglqol}.sp "${PLUGIN_INSTALL_DIR}/addons/sourcemod/scripting/" \
  && mkdir "${PLUGIN_INSTALL_DIR}/addons/sourcemod/plugins/disabled" \
  && cp "addons/sourcemod/plugins/disabled/"{p4sstime,roundtimer_override}.smx "${PLUGIN_INSTALL_DIR}/addons/sourcemod/plugins/disabled/" \
  && mkdir "${PLUGIN_INSTALL_DIR}/addons/sourcemod/scripting/disabled" \
  && cp "addons/sourcemod/scripting/disabled/roundtimer_override.sp" "${PLUGIN_INSTALL_DIR}/addons/sourcemod/scripting/disabled/"

ARG ULTITRIO_CONFIGS_VERSION=3.2.1
ARG ULTITRIO_CONFIGS_FILE_NAME=Ultitrio-${ULTITRIO_CONFIGS_VERSION}.zip
ARG ULTITRIO_CONFIGS_URL=https://github.com/CoolstuffTF2/Ultitrio/archive/refs/tags/v${ULTITRIO_CONFIGS_VERSION}.zip
ARG ULTITRIO_CONFIGS_CHECKSUM=73c5a7daca365bc8e5461e49bd42430aec482c0e5d9e155651cbb54cd18e1a29
ADD --checksum=sha256:${ULTITRIO_CONFIGS_CHECKSUM} ${ULTITRIO_CONFIGS_URL} ./${ULTITRIO_CONFIGS_FILE_NAME}
RUN unzip -q "${ULTITRIO_CONFIGS_FILE_NAME}" \
  && cp "Ultitrio-${ULTITRIO_CONFIGS_VERSION}/ultitrio_"*.{cfg,txt} "${PLUGIN_INSTALL_DIR}/cfg/"

ARG DEMOS_TF_FILE_NAME=demostf.smx
ARG DEMOS_TF_URL=https://github.com/demostf/plugin/raw/master/${DEMOS_TF_FILE_NAME}
ARG DEMOS_TF_CHECKSUM=e2fad4e7970ed0eb609d29ce17336408963debba9a3392768404cdff47fd90d0
ADD --checksum=sha256:${DEMOS_TF_CHECKSUM} ${DEMOS_TF_URL} .
RUN cp "${DEMOS_TF_FILE_NAME}" "${PLUGIN_INSTALL_DIR}/addons/sourcemod/plugins/"

ARG TF2RUE_FILE_NAME=tf2rue.zip
ARG TF2RUE_VERSION=v0.0.13
ARG TF2RUE_URL=https://github.com/sapphonie/tf2rue/releases/download/${TF2RUE_VERSION}/${TF2RUE_FILE_NAME}
ARG TF2RUE_CHECKSUM=670f228f287bb55c4418ff8241032582189621a944a420f42ddae9db6754b6cd
ADD --checksum=sha256:${TF2RUE_CHECKSUM} ${TF2RUE_URL} .
RUN unzip -q -n "${TF2RUE_FILE_NAME}" -d "${PLUGIN_INSTALL_DIR}/addons/sourcemod/"

ARG IMPROVED_MATCH_TIMER_FILE_NAME=Improved-Match-Timer-main.zip
ARG IMPROVED_MATCH_TIMER_URL=https://github.com/dewbsku/Improved-Match-Timer/archive/refs/heads/main.zip
ARG IMPROVED_MATCH_TIMER_CHECKSUM=413ad48cc1c2386723ba727286314b5a9029db76d6bf73a1163029ee03f5e26b
ADD --checksum=sha256:${IMPROVED_MATCH_TIMER_CHECKSUM} ${IMPROVED_MATCH_TIMER_URL} ${IMPROVED_MATCH_TIMER_FILE_NAME}
RUN unzip -q "${IMPROVED_MATCH_TIMER_FILE_NAME}" \
  && cp "Improved-Match-Timer-main/addons/sourcemod/plugins/"*.smx "${PLUGIN_INSTALL_DIR}/addons/sourcemod/plugins/" \
  && cp "Improved-Match-Timer-main/addons/sourcemod/scripting/"*.sp "${PLUGIN_INSTALL_DIR}/addons/sourcemod/scripting/"

ARG UPDATED_PAUSE_FILE_NAME=updated-pause-plugin.zip
ARG UPDATED_PAUSE_VERSION=v1.4.2
ARG UPDATED_PAUSE_URL=https://github.com/l-Aad-l/updated-pause-plugin/releases/download/${UPDATED_PAUSE_VERSION}/${UPDATED_PAUSE_FILE_NAME}
ARG UPDATED_PAUSE_CHECKSUM=5fb97a7be0f1246c25ebd674fd87f755f2adca1021c53f4022a6e25f547ea134
ADD --checksum=sha256:${UPDATED_PAUSE_CHECKSUM} ${UPDATED_PAUSE_URL} .
RUN unzip -q -o "${UPDATED_PAUSE_FILE_NAME}" -d "${PLUGIN_INSTALL_DIR}/"

ARG SRCTV_PLUS_VERSION=v3.0
ARG SRCTV_PLUS_SO_FILE_NAME=srctvplus.so
ARG SRCTV_PLUS_SO_URL=https://github.com/dalegaard/srctvplus/releases/download/${SRCTV_PLUS_VERSION}/${SRCTV_PLUS_SO_FILE_NAME}
ARG SRCTV_PLUS_SO_CHECKSUM=5063cf4a29bc9b9ddb8d4703ac0128e62ea6a4c976439e0e77d4085646704fe2
ADD --checksum=sha256:${SRCTV_PLUS_SO_CHECKSUM} ${SRCTV_PLUS_SO_URL} .
RUN cp "${SRCTV_PLUS_SO_FILE_NAME}" "${PLUGIN_INSTALL_DIR}/addons/${SRCTV_PLUS_SO_FILE_NAME}"

ARG SRCTV_PLUS_VDF_FILE_NAME=srctvplus.vdf
ARG SRCTV_PLUS_VDF_URL=https://github.com/dalegaard/srctvplus/releases/download/${SRCTV_PLUS_VERSION}/${SRCTV_PLUS_VDF_FILE_NAME}
ARG SRCTV_PLUS_VDF_CHECKSUM=886287c911200c1f2f0effc232fd01740cc0913cd92723fdf27cf3c52854beba
ADD --checksum=sha256:${SRCTV_PLUS_VDF_CHECKSUM} ${SRCTV_PLUS_VDF_URL} .
RUN cp "${SRCTV_PLUS_VDF_FILE_NAME}" "${PLUGIN_INSTALL_DIR}/addons/${SRCTV_PLUS_VDF_FILE_NAME}"

ARG MAPDOWNLOADER_PLUGIN_FILE_NAME=mapdownloader.smx
ARG MAPDOWNLOADER_PLUGIN_URL=https://github.com/spiretf/mapdownloader/raw/master/plugin/${MAPDOWNLOADER_PLUGIN_FILE_NAME}
ARG MAPDOWNLOADER_PLUGIN_CHECKSUM=53d4a64d40a939837dd3dfbf41aa3e682c421da44efb4f16c3db397aa2901ed2
ADD --checksum=sha256:${MAPDOWNLOADER_PLUGIN_CHECKSUM} ${MAPDOWNLOADER_PLUGIN_URL} .
RUN cp "${MAPDOWNLOADER_PLUGIN_FILE_NAME}" "${PLUGIN_INSTALL_DIR}/addons/sourcemod/plugins/${MAPDOWNLOADER_PLUGIN_FILE_NAME}"

ARG SDR_PLUGIN_FILE_NAME=showsdr.zip
ARG SDR_PLUGIN_VERSION=1.0.0
ARG SDR_PLUGIN_URL=https://github.com/Red-X1/sdr-plugin/releases/download/${SDR_PLUGIN_VERSION}/${SDR_PLUGIN_FILE_NAME}
ARG SDR_PLUGIN_CHECKSUM=9668b437b5d091f564fd2333c9d3db6c1d5cf04eeb52d1639ad85cc3bb18ec0f
ADD --checksum=sha256:${SDR_PLUGIN_CHECKSUM} ${SDR_PLUGIN_URL} .
RUN unzip -q -o "${SDR_PLUGIN_FILE_NAME}" -d "${PLUGIN_INSTALL_DIR}/addons/sourcemod/"

FROM ${REGISTRY}/melkortf/tf2-sourcemod/i386:${TF2_SOURCEMOD_TAG}
LABEL maintainer="garrappachc@gmail.com"

ARG PLUGIN_INSTALL_DIR=/server/tf
COPY --from=plugins --chown=tf2 "${PLUGIN_INSTALL_DIR}/" "${SERVER_DIR}/tf/"

# disable useless (and potentially harmful) plugins
RUN mv "${SERVER_DIR}/tf/addons/sourcemod/plugins/"{nextmap,funcommands,funvotes}.smx "${SERVER_DIR}/tf/addons/sourcemod/plugins/disabled/"

ENV DEMOS_TF_APIKEY=
ENV LOGS_TF_APIKEY=

COPY cfg/* ${SERVER_DIR}/tf/cfg/

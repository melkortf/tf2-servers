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
ARG COMP_FIXES_VERSION=1.16.19
ARG COMP_FIXES_URL=https://github.com/ldesgoui/tf2-comp-fixes/releases/download/v${COMP_FIXES_VERSION}/${COMP_FIXES_FILE_NAME}
ARG COMP_FIXES_CHECKSUM=4a54bdafda9d8f462ac5bfcc9d402840f1954dbfacdb5d17a06e20b796e760e1
ADD --checksum=sha256:${COMP_FIXES_CHECKSUM} ${COMP_FIXES_URL} .
RUN unzip -q -o "${COMP_FIXES_FILE_NAME}" -d "${PLUGIN_INSTALL_DIR}/"

ARG MGEMOD_FILE_NAME=mge.zip
ARG MGEMOD_VERSION=v3.0.7
ARG MGEMOD_URL=https://github.com/sapphonie/MGEMod/releases/download/${MGEMOD_VERSION}/${MGEMOD_FILE_NAME}
ARG MGEMOD_CHECKSUM=cb0abb7915d2e3074a80f6e4bd28423cfe038e89f85dc7acd55652c8bd229117
ADD --checksum=sha256:${MGEMOD_CHECKSUM} ${MGEMOD_URL} .
RUN unzip -q -n "${MGEMOD_FILE_NAME}" -d "${PLUGIN_INSTALL_DIR}/"

ARG NEOCURL_FILE_NAME=sm-neocurl-repack.zip
ARG NEOCURL_VERSION=v2.0.1-beta1
ARG NEOCURL_URL=https://github.com/sapphonie/SM-neocurl-ext/releases/download/${NEOCURL_VERSION}/${NEOCURL_FILE_NAME}
ARG NEOCURL_CHECKSUM=cddbef00ca5b4b2a14c35fd062fe18586fb42f68c6d6366bf74f5b72a5734e44
ADD --checksum=sha256:${NEOCURL_CHECKSUM} ${NEOCURL_URL} .
RUN unzip -q -o "${NEOCURL_FILE_NAME}" -d "${PLUGIN_INSTALL_DIR}/addons/sourcemod/"

ARG F2_SOURCEMOD_PLUGINS_FILE_NAME=f2-sourcemod-plugins.zip
ARG F2_SOURCEMOD_PLUGINS_VERSION=20250321-1742561972181
ARG F2_SOURCEMOD_PLUGINS_URL=https://github.com/F2/F2s-sourcemod-plugins/releases/download/${F2_SOURCEMOD_PLUGINS_VERSION}/${F2_SOURCEMOD_PLUGINS_FILE_NAME}
ARG F2_SOURCEMOD_PLUGINS_CHECKSUM=cfbac61a8f0967960a50e209565b8a5c929c6ac55afb656b63b3ef110549bd8e
ADD --checksum=sha256:${F2_SOURCEMOD_PLUGINS_CHECKSUM} ${F2_SOURCEMOD_PLUGINS_URL} .
ARG F2_ENABLED_PLUGINS="afk.smx fixstvslot.smx logstf.smx medicstats.smx recordstv.smx restorescore.smx supstats2.smx waitforstv.smx"
RUN unzip -q -j "${F2_SOURCEMOD_PLUGINS_FILE_NAME}" ${F2_ENABLED_PLUGINS} \
  -d "${PLUGIN_INSTALL_DIR}/addons/sourcemod/plugins/"

ARG ETF2L_CONFIGS_FILE_NAME=etf2l_configs.zip
ARG ETF2L_CONFIGS_VERSION=1.0.20
ARG ETF2L_CONFIGS_URL=https://github.com/ETF2L/gameserver-configs/releases/download/${ETF2L_CONFIGS_VERSION}/${ETF2L_CONFIGS_FILE_NAME}
ARG ETF2L_CONFIGS_CHECKSUM=aab4b498dc242fe8c18e7f50259e5978295f746f84a27fe637a1838751473243
ADD --checksum=sha256:${ETF2L_CONFIGS_CHECKSUM} ${ETF2L_CONFIGS_URL} .
RUN unzip -q "${ETF2L_CONFIGS_FILE_NAME}" -d "${PLUGIN_INSTALL_DIR}/cfg/"

ARG FBTF_CONFIGS_VERSION=23
ARG FBTF_CONFIGS_FILE_NAME=fbtf_cfg_s${FBTF_CONFIGS_VERSION}.zip
ARG FBTF_CONFIGS_URL=https://fbtf.tf/uploads/cfgs/${FBTF_CONFIGS_FILE_NAME}
ARG FBTF_CONFIGS_CHECKSUM=cd62879b4ba18cf27117d800a605330464a2a269b3b3add1575a9a8aa2e8ff3e
ADD --checksum=sha256:${FBTF_CONFIGS_CHECKSUM} ${FBTF_CONFIGS_URL} .
RUN unzip -q "${FBTF_CONFIGS_FILE_NAME}" -d "${PLUGIN_INSTALL_DIR}/cfg/"

ARG RGL_CONFIGS_FILE_NAME=server-resources-updater.zip
ARG RGL_CONFIGS_VERSION=v256
ARG RGL_CONFIGS_URL=https://github.com/RGLgg/server-resources-updater/releases/download/${RGL_CONFIGS_VERSION}/${RGL_CONFIGS_FILE_NAME}
ARG RGL_CONFIGS_CHECKSUM=c0730a631e1b27a1d19ff94cb5ef06693990c755e543f20d53ae8aa30d4b4ba4
ADD --checksum=sha256:${RGL_CONFIGS_CHECKSUM} ${RGL_CONFIGS_URL} .
RUN unzip -q "${RGL_CONFIGS_FILE_NAME}" \
  && cp "cfg/"* "${PLUGIN_INSTALL_DIR}/cfg/" \
  && cp "addons/sourcemod/plugins/"{config_checker,rglqol}.smx "${PLUGIN_INSTALL_DIR}/addons/sourcemod/plugins/" \
  && cp "addons/sourcemod/scripting/"{config_checker,rglqol}.sp "${PLUGIN_INSTALL_DIR}/addons/sourcemod/scripting/" \
  && mkdir "${PLUGIN_INSTALL_DIR}/addons/sourcemod/plugins/disabled" \
  && cp "addons/sourcemod/plugins/disabled/"{p4sstime,tf2Halftime,roundtimer_override}.smx "${PLUGIN_INSTALL_DIR}/addons/sourcemod/plugins/disabled/" \
  && mkdir "${PLUGIN_INSTALL_DIR}/addons/sourcemod/scripting/disabled" \
  && cp "addons/sourcemod/scripting/disabled/roundtimer_override.sp" "${PLUGIN_INSTALL_DIR}/addons/sourcemod/scripting/disabled/"

ARG DEMOS_TF_FILE_NAME=demostf.smx
ARG DEMOS_TF_URL=https://github.com/demostf/plugin/raw/master/${DEMOS_TF_FILE_NAME}
ARG DEMOS_TF_CHECKSUM=e2fad4e7970ed0eb609d29ce17336408963debba9a3392768404cdff47fd90d0
ADD --checksum=sha256:${DEMOS_TF_CHECKSUM} ${DEMOS_TF_URL} .
RUN cp "${DEMOS_TF_FILE_NAME}" "${PLUGIN_INSTALL_DIR}/addons/sourcemod/plugins/"

ARG TF2RUE_FILE_NAME=tf2rue.zip
ARG TF2RUE_VERSION=v0.0.12
ARG TF2RUE_URL=https://github.com/sapphonie/tf2rue/releases/download/${TF2RUE_VERSION}/${TF2RUE_FILE_NAME}
ARG TF2RUE_CHECKSUM=58add29f81f4b4c98a0ef1ef07d68e8e348556936284da8bbdec8ddcab3bda71
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
ARG UPDATED_PAUSE_URL=https://github.com/l-Aad-l/updated-pause-plugin/releases/download/v1.4.2/${UPDATED_PAUSE_FILE_NAME}
ARG UPDATED_PAUSE_CHECKSUM=5fb97a7be0f1246c25ebd674fd87f755f2adca1021c53f4022a6e25f547ea134
ADD --checksum=sha256:${UPDATED_PAUSE_CHECKSUM} ${UPDATED_PAUSE_URL} .
RUN unzip -q -o "${UPDATED_PAUSE_FILE_NAME}" -d "${PLUGIN_INSTALL_DIR}/"

ARG SHOWSDR_PLUGIN_FILE_NAME=showsdr.zip
ARG SHOWSDR_PLUGIN_VERSION=1.0.0
ARG SHOWSDR_PLUGIN_URL=https://github.com/Full-Buff/sdr-plugin/releases/download/${SHOWSDR_PLUGIN_VERSION}/${SHOWSDR_PLUGIN_FILE_NAME}
ARG SHOWSDR_PLUGIN_CHECKSUM=25ea96b29472fb349b06ef129151779c43afcba5c0cbda263a0342705f7340ef
ADD --checksum=sha256:${SHOWSDR_PLUGIN_CHECKSUM} ${SHOWSDR_PLUGIN_URL} .
RUN unzip -q -n "${SHOWSDR_PLUGIN_FILE_NAME}" -d "${PLUGIN_INSTALL_DIR}/addons/sourcemod/"

ARG SRCTV_PLUS_VERSION=v3.0
ARG SRCTV_PLUS_SO_FILE_NAME=srctvplus.so
ARG SRCTV_PLUS_SO_URL=https://github.com/dalegaard/srctvplus/releases/download/${SRCTV_PLUS_VERSION}/${SRCTV_PLUS_SO_FILE_NAME}
ARG SRCTV_PLUS_SO_CHECKSUM=e9bcb450515d80e187cdccfc1c75f230d2d6200666e2b0d65f2f028a59fcdf49
ADD --checksum=sha256:${SRCTV_PLUS_SO_CHECKSUM} ${SRCTV_PLUS_SO_URL} .
RUN cp "${SRCTV_PLUS_SO_FILE_NAME}" "${PLUGIN_INSTALL_DIR}/addons/${SRCTV_PLUS_SO_FILE_NAME}"

ARG SRCTV_PLUS_VDF_FILE_NAME=srctvplus.vdf
ARG SRCTV_PLUS_VDF_URL=https://github.com/dalegaard/srctvplus/releases/download/${SRCTV_PLUS_VERSION}/${SRCTV_PLUS_VDF_FILE_NAME}
ARG SRCTV_PLUS_VDF_CHECKSUM=886287c911200c1f2f0effc232fd01740cc0913cd92723fdf27cf3c52854beba
ADD --checksum=sha256:${SRCTV_PLUS_VDF_CHECKSUM} ${SRCTV_PLUS_VDF_URL} .
RUN cp "${SRCTV_PLUS_VDF_FILE_NAME}" "${PLUGIN_INSTALL_DIR}/addons/${SRCTV_PLUS_VDF_FILE_NAME}"

FROM ${REGISTRY}/melkortf/tf2-sourcemod/i386:${TF2_SOURCEMOD_TAG}
LABEL maintainer="garrappachc@gmail.com"

ARG PLUGIN_INSTALL_DIR=/server/tf
COPY --from=plugins --chown=tf2 "${PLUGIN_INSTALL_DIR}/" "${SERVER_DIR}/tf/"

# disable useless (and potentially harmful) plugins
RUN mv "${SERVER_DIR}/tf/addons/sourcemod/plugins/"{nextmap,funcommands,funvotes}.smx "${SERVER_DIR}/tf/addons/sourcemod/plugins/disabled/"

ENV DEMOS_TF_APIKEY=
ENV LOGS_TF_APIKEY=

COPY cfg/* ${SERVER_DIR}/tf/cfg/

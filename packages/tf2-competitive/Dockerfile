ARG REGISTRY=ghcr.io
ARG TF2_SOURCEMOD_TAG=latest
FROM ${REGISTRY}/melkortf/tf2-sourcemod/i386:${TF2_SOURCEMOD_TAG}
LABEL maintainer="garrappachc@gmail.com"

COPY checksum.md5 .

ARG SOAP_DM_PLUGIN_FILE_NAME=soap.zip
ARG SOAP_DM_PLUGIN_VERSION=4.4.7
ARG SOAP_DM_PLUGIN_URL=https://github.com/sapphonie/SOAP-TF2DM/releases/download/v${SOAP_DM_PLUGIN_VERSION}/${SOAP_DM_PLUGIN_FILE_NAME}

ARG COMP_FIXES_PLUGIN_FILE_NAME=tf2-comp-fixes.zip
ARG COMP_FIXES_PLUGIN_VERSION=1.16.19
ARG COMP_FIXES_PLUGIN_URL=https://github.com/ldesgoui/tf2-comp-fixes/releases/download/v${COMP_FIXES_PLUGIN_VERSION}/${COMP_FIXES_PLUGIN_FILE_NAME}

ARG UPDATED_PAUSE_PLUGIN_FILE_NAME=updated-pause-plugin.zip
ARG UPDATED_PAUSE_PLUGIN_URL=https://github.com/l-Aad-l/updated-pause-plugin/releases/download/v1.4.2/${UPDATED_PAUSE_PLUGIN_FILE_NAME}

ARG MGEMOD_PLUGIN_FILE_NAME=mge.zip
ARG MGEMOD_PLUGIN_VERSION=v3.0.7
ARG MGEMOD_PLUGIN_URL=https://github.com/sapphonie/MGEMod/releases/download/${MGEMOD_PLUGIN_VERSION}/mge.zip

ARG NEOCURL_PLUGIN_FILE_NAME=sm-neocurl-repack.zip
ARG NEOCURL_PLUGIN_VERSION=v2.0.1-beta1
ARG NEOCURL_PLUGIN_URL=https://github.com/sapphonie/SM-neocurl-ext/releases/download/${NEOCURL_PLUGIN_VERSION}/${NEOCURL_PLUGIN_FILE_NAME}

ARG ETF2L_CONFIGS_FILE_NAME=etf2l_configs.zip
ARG ETF2L_CONFIGS_VERSION=1.0.20
ARG ETF2L_CONFIGS_URL=https://github.com/ETF2L/gameserver-configs/releases/download/${ETF2L_CONFIGS_VERSION}/${ETF2L_CONFIGS_FILE_NAME}

ARG RGL_CONFIGS_FILE_NAME=server-resources-updater.zip
ARG RGL_CONFIGS_VERSION=v256
ARG RGL_CONFIGS_URL=https://github.com/RGLgg/server-resources-updater/releases/download/${RGL_CONFIGS_VERSION}/${RGL_CONFIGS_FILE_NAME}

ARG FBTF_CONFIGS_VERSION=23
ARG FBTF_CONFIGS_FILE_NAME=fbtf_cfg_s${FBTF_CONFIGS_VERSION}.zip
ARG FBTF_CONFIGS_URL=https://fbtf.tf/uploads/cfgs/fbtf_cfg_s${FBTF_CONFIGS_VERSION}.zip

ARG DEMOS_TF_PLUGIN_FILE_NAME=demostf.smx
ARG DEMOS_TF_PLUGIN_URL=https://github.com/demostf/plugin/raw/master/${DEMOS_TF_PLUGIN_FILE_NAME}

ARG SRCTV_PLUS_VERSION=v3.0
ARG SRCTV_PLUS_SO_FILE_NAME=srctvplus.so
ARG SRCTV_PLUS_SO_URL=https://github.com/dalegaard/srctvplus/releases/download/${SRCTV_PLUS_VERSION}/${SRCTV_PLUS_SO_FILE_NAME}

ARG SRCTV_PLUS_VDF_FILE_NAME=srctvplus.vdf
ARG SRCTV_PLUS_VDF_URL=https://github.com/dalegaard/srctvplus/releases/download/${SRCTV_PLUS_VERSION}/${SRCTV_PLUS_VDF_FILE_NAME}

ARG IMPROVED_MATCH_TIMER_PLUGIN_FILE_NAME=Improved-Match-Timer-main.zip
ARG IMPROVED_MATCH_TIMER_PLUGIN_URL=https://github.com/dewbsku/Improved-Match-Timer/archive/refs/heads/main.zip

ARG F2_SOURCEMOD_PLUGINS_FILE_NAME=f2-sourcemod-plugins.zip
ARG F2_SOURCEMOD_PLUGINS_VERSION=20250321-1742561972181
ARG F2_SOURCEMOD_PLUGINS_URL=https://github.com/F2/F2s-sourcemod-plugins/releases/download/${F2_SOURCEMOD_PLUGINS_VERSION}/${F2_SOURCEMOD_PLUGINS_FILE_NAME}
ARG F2_ENABLED_PLUGINS="afk.smx fixstvslot.smx logstf.smx medicstats.smx recordstv.smx restorescore.smx supstats2.smx waitforstv.smx"

ARG TF2RUE_PLUGIN_FILE_NAME=tf2rue.zip
ARG TF2RUE_PLUGIN_VERSION=v0.0.12
ARG TF2RUE_PLUGIN_URL=https://github.com/sapphonie/tf2rue/releases/download/${TF2RUE_PLUGIN_VERSION}/${TF2RUE_PLUGIN_FILE_NAME}

RUN \
  # download all the plugins
  wget -nv "${SOAP_DM_PLUGIN_URL}" "${COMP_FIXES_PLUGIN_URL}" "${UPDATED_PAUSE_PLUGIN_URL}" "${NEOCURL_PLUGIN_URL}" \
  "${ETF2L_CONFIGS_URL}" "${RGL_CONFIGS_URL}" "${FBTF_CONFIGS_URL}" "${DEMOS_TF_PLUGIN_URL}" "${SRCTV_PLUS_SO_URL}" "${SRCTV_PLUS_VDF_URL}" \
  "${F2_SOURCEMOD_PLUGINS_URL}" "${TF2RUE_PLUGIN_URL}" "${MGEMOD_PLUGIN_URL}" \
  && wget -nv "${IMPROVED_MATCH_TIMER_PLUGIN_URL}" -O "${IMPROVED_MATCH_TIMER_PLUGIN_FILE_NAME}" \
  # verify md5 checksums
  && md5sum -c checksum.md5 \
  # install plugins
  && unzip -q "${SOAP_DM_PLUGIN_FILE_NAME}" -d "${SERVER_DIR}/tf/" \
  && unzip -q -o "${COMP_FIXES_PLUGIN_FILE_NAME}" -d "${SERVER_DIR}/tf/" \
  && unzip -q -o "${UPDATED_PAUSE_PLUGIN_FILE_NAME}" -d "${SERVER_DIR}/tf/" \
  && unzip -q -o "${NEOCURL_PLUGIN_FILE_NAME}" -d "${SERVER_DIR}/tf/addons/sourcemod" \
  && unzip -q "${ETF2L_CONFIGS_FILE_NAME}" -d "${SERVER_DIR}/tf/cfg/" \
  && unzip -q -j "${FBTF_CONFIGS_FILE_NAME}" -d "${SERVER_DIR}/tf/cfg/" \
  && unzip -q "${RGL_CONFIGS_FILE_NAME}" "cfg/*.cfg" && mv "cfg/"* "${SERVER_DIR}/tf/cfg/" \
  && unzip -q "${RGL_CONFIGS_FILE_NAME}" "addons/sourcemod/plugins/"{config_checker,rglqol}.smx && mv "addons/sourcemod/plugins/"* "${SERVER_DIR}/tf/addons/sourcemod/plugins/" \
  && unzip -q "${RGL_CONFIGS_FILE_NAME}" "addons/sourcemod/scripting/"{config_checker,rglqol}.sp && mv "addons/sourcemod/scripting/"* "${SERVER_DIR}/tf/addons/sourcemod/scripting/" \
  && unzip -q "${RGL_CONFIGS_FILE_NAME}" "addons/sourcemod/plugins/disabled/"{p4sstime,tf2Halftime,roundtimer_override}.smx && mv "addons/sourcemod/plugins/disabled/"* "${SERVER_DIR}/tf/addons/sourcemod/plugins/disabled" \
  && unzip -q "${RGL_CONFIGS_FILE_NAME}" "addons/sourcemod/scripting/disabled/roundtimer_override.sp" && mv "addons/sourcemod/scripting/disabled/"* "${SERVER_DIR}/tf/addons/sourcemod/scripting/disabled" \
  && unzip -q "${IMPROVED_MATCH_TIMER_PLUGIN_FILE_NAME}" \
  && unzip -q -n "${MGEMOD_PLUGIN_FILE_NAME}" -d "${SERVER_DIR}/tf" \
  && mv "Improved-Match-Timer-main/addons/sourcemod/plugins/"*.smx "${SERVER_DIR}/tf/addons/sourcemod/plugins/" \
  && mv "Improved-Match-Timer-main/addons/sourcemod/scripting/"*.sp "${SERVER_DIR}/tf/addons/sourcemod/scripting/" \
  && mv "${DEMOS_TF_PLUGIN_FILE_NAME}" "${SERVER_DIR}/tf/addons/sourcemod/plugins/${DEMOS_TF_PLUGIN_FILE_NAME}" \
  && mv "${SRCTV_PLUS_SO_FILE_NAME}" "${SERVER_DIR}/tf/addons/${SRCTV_PLUS_SO_FILE_NAME}" \
  && mv "${SRCTV_PLUS_VDF_FILE_NAME}" "${SERVER_DIR}/tf/addons/${SRCTV_PLUS_VDF_FILE_NAME}" \
  && unzip -q -j "${F2_SOURCEMOD_PLUGINS_FILE_NAME}" ${F2_ENABLED_PLUGINS} -d "${SERVER_DIR}/tf/addons/sourcemod/plugins/" \
  && unzip -q -n "${TF2RUE_PLUGIN_FILE_NAME}" -d "${SERVER_DIR}/tf/addons/sourcemod/" \
  # cleanup
  && rm "${SOAP_DM_PLUGIN_FILE_NAME}" \
  && rm "${COMP_FIXES_PLUGIN_FILE_NAME}" \
  && rm "${UPDATED_PAUSE_PLUGIN_FILE_NAME}" \
  && rm "${MGEMOD_PLUGIN_FILE_NAME}" \
  && rm "${NEOCURL_PLUGIN_FILE_NAME}" \
  && rm "${ETF2L_CONFIGS_FILE_NAME}" \
  && rm "${FBTF_CONFIGS_FILE_NAME}" \
  && rm -r "${RGL_CONFIGS_FILE_NAME}" "cfg" \
  && rm -r "${IMPROVED_MATCH_TIMER_PLUGIN_FILE_NAME}" "Improved-Match-Timer-main" \
  && rm "${F2_SOURCEMOD_PLUGINS_FILE_NAME}" "${TF2RUE_PLUGIN_FILE_NAME}" \
  && rm "checksum.md5" \
  # remove useless (and potentially harmful) plugins
  && rm "$SERVER_DIR/tf/addons/sourcemod/plugins/"{nextmap,funcommands,funvotes}.smx


ENV DEMOS_TF_APIKEY=
ENV LOGS_TF_APIKEY=

COPY cfg/* ${SERVER_DIR}/tf/cfg/

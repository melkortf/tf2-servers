ARG TF2_SOURCEMOD_TAG=latest
FROM melkortf/tf2-sourcemod:${TF2_SOURCEMOD_TAG}
LABEL maintainer="garrappachc@gmail.com"

COPY checksum.md5 .

ARG SOAP_DM_PLUGIN_FILE_NAME=soap.zip
ARG SOAP_DM_PLUGIN_VERSION=4.4.2
ARG SOAP_DM_PLUGIN_URL=https://github.com/sapphonie/SOAP-TF2DM/releases/download/v${SOAP_DM_PLUGIN_VERSION}/${SOAP_DM_PLUGIN_FILE_NAME}

ARG DHOOKS_PLUGIN_FILE_NAME=dhooks-2.2.0-detours17-sm110.zip
ARG DHOOKS_PLUGIN_URL=https://github.com/peace-maker/DHooks2/releases/download/v2.2.0-detours17/${DHOOKS_PLUGIN_FILE_NAME}

ARG COMP_FIXES_PLUGIN_FILE_NAME=tf2-comp-fixes.zip
ARG COMP_FIXES_PLUGIN_VERSION=1.16.10
ARG COMP_FIXES_PLUGIN_URL=https://github.com/ldesgoui/tf2-comp-fixes/releases/download/v${COMP_FIXES_PLUGIN_VERSION}/${COMP_FIXES_PLUGIN_FILE_NAME}

ARG UPDATED_PAUSE_PLUGIN_FILE_NAME=updated-pause-plugin.zip
ARG UPDATED_PAUSE_PLUGIN_URL=https://github.com/l-Aad-l/updated-pause-plugin/releases/download/v1.4.2/${UPDATED_PAUSE_PLUGIN_FILE_NAME}

ARG MGEMOD_PLUGIN_FILE_NAME=mgemod.zip
ARG MGEMOD_PLUGIN_URL=https://github.com/sapphonie/MGEMod/archive/master.zip

ARG CURL_PLUGIN_FILE_NAME=curl_1.3.0.0.zip
ARG CURL_PLUGIN_URL=https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/sourcemod-curl-extension/${CURL_PLUGIN_FILE_NAME}
ARG CURL_EXTENSION_FILE_NAME=curl.ext.so
ARG CURL_EXTENSION_URL=https://raw.githubusercontent.com/spiretf/docker-comp-server/master/${CURL_EXTENSION_FILE_NAME}

ARG ETF2L_CONFIGS_FILE_NAME=etf2l_configs.zip
ARG ETF2L_CONFIGS_VERSION=1.0.5
ARG ETF2L_CONFIGS_URL=https://github.com/ETF2L/gameserver-configs/releases/download/${ETF2L_CONFIGS_VERSION}/${ETF2L_CONFIGS_FILE_NAME}

ARG RGL_CONFIGS_FILE_NAME=server-resources-updater.zip
ARG RGL_CONFIGS_VERSION=v117
ARG RGL_CONFIGS_URL=https://github.com/RGLgg/server-resources-updater/releases/download/${RGL_CONFIGS_VERSION}/${RGL_CONFIGS_FILE_NAME}

ARG DEMOS_TF_PLUGIN_FILE_NAME=demostf.smx
ARG DEMOS_TF_PLUGIN_URL=https://github.com/demostf/plugin/raw/master/${DEMOS_TF_PLUGIN_FILE_NAME}

ARG SRCTV_PLUS_SO_FILE_NAME=srctvplus.so
ARG SRCTV_PLUS_SO_URL=https://github.com/dalegaard/srctvplus/releases/download/v2.0/${SRCTV_PLUS_SO_FILE_NAME}

ARG SRCTV_PLUS_VDF_FILE_NAME=srctvplus.vdf
ARG SRCTV_PLUS_VDF_URL=https://github.com/dalegaard/srctvplus/releases/download/v2.0/${SRCTV_PLUS_VDF_FILE_NAME}

ARG IMPROVED_MATCH_TIMER_PLUGIN_FILE_NAME=Improved-Match-Timer-main.zip
ARG IMPROVED_MATCH_TIMER_PLUGIN_URL=https://github.com/dewbsku/Improved-Match-Timer/archive/refs/heads/main.zip

ARG SUPSTATS2_PLUGIN_FILE_NAME=supstats2.zip
ARG SUPSTATS2_PLUGIN_URL=http://sourcemod.krus.dk/supstats2.zip

ARG MEDIC_STATS_PLUGIN_FILE_NAME=medicstats.zip
ARG MEDIC_STATS_PLUGIN_URL=http://sourcemod.krus.dk/medicstats.zip

ARG RESTORE_SCORE_PLUGIN_FILE_NAME=restorescore.zip
ARG RESTORE_SCORE_PLUGIN_URL=http://sourcemod.krus.dk/restorescore.zip

ARG LOGSTF_PLUGIN_FILE_NAME=logstf.zip
ARG LOGSTF_PLUGIN_URL=http://sourcemod.krus.dk/logstf.zip

ARG RECORD_STV_PLUGIN_FILE_NAME=recordstv.zip
ARG RECORD_STV_PLUGIN_URL=http://sourcemod.krus.dk/recordstv.zip

ARG WAIT_FOR_STV_PLUGIN_FILE_NAME=waitforstv.zip
ARG WAIT_FOR_STV_PLUGIN_URL=http://sourcemod.krus.dk/waitforstv.zip

ARG FIX_STV_SLOT_PLUGIN_FILE_NAME=fixstvslot.zip
ARG FIX_STV_SLOT_PLUGIN_URL=http://sourcemod.krus.dk/fixstvslot.zip

ARG AFK_PLUGIN_FILE_NAME=afk.zip
ARG AFK_PLUGIN_URL=http://sourcemod.krus.dk/afk.zip

RUN \
  # download all the plugins
  wget -nv "${SOAP_DM_PLUGIN_URL}" "${DHOOKS_PLUGIN_URL}" "${COMP_FIXES_PLUGIN_URL}" "${UPDATED_PAUSE_PLUGIN_URL}" "${CURL_PLUGIN_URL}" \
    "${CURL_EXTENSION_URL}" "${ETF2L_CONFIGS_URL}" "${RGL_CONFIGS_URL}" "${DEMOS_TF_PLUGIN_URL}" "${SRCTV_PLUS_SO_URL}" "${SRCTV_PLUS_VDF_URL}" \
    "${SUPSTATS2_PLUGIN_URL}" "${MEDIC_STATS_PLUGIN_URL}" "${RESTORE_SCORE_PLUGIN_URL}" "${LOGSTF_PLUGIN_URL}" "${RECORD_STV_PLUGIN_URL}" \
    "${WAIT_FOR_STV_PLUGIN_URL}" "${FIX_STV_SLOT_PLUGIN_URL}" "${AFK_PLUGIN_FILE_NAME}" \
  && wget -nv "${MGEMOD_PLUGIN_URL}" -O "${MGEMOD_PLUGIN_FILE_NAME}" \
  && wget -nv "${IMPROVED_MATCH_TIMER_PLUGIN_URL}" -O "${IMPROVED_MATCH_TIMER_PLUGIN_FILE_NAME}" \
  # verify md5 checksums
  && md5sum -c checksum.md5 \
  # install plugins
  && unzip -q "${SOAP_DM_PLUGIN_FILE_NAME}" -d "${SERVER_DIR}/tf/" \
  && unzip -q "${DHOOKS_PLUGIN_FILE_NAME}" -d "${SERVER_DIR}/tf/" \
  && unzip -q -o "${COMP_FIXES_PLUGIN_FILE_NAME}" -d "${SERVER_DIR}/tf/" \
  && unzip -q -o "${UPDATED_PAUSE_PLUGIN_FILE_NAME}" -d "${SERVER_DIR}/tf/" \
  && unzip -q "${MGEMOD_PLUGIN_FILE_NAME}" && cp -r "MGEMod-master/addons" "${SERVER_DIR}/tf/" \
  && unzip -q -o "${CURL_PLUGIN_FILE_NAME}" -d "${SERVER_DIR}/tf/addons/sourcemod" \
  && unzip -q "${ETF2L_CONFIGS_FILE_NAME}" -d "${SERVER_DIR}/tf/cfg/" \
  && unzip -q "${RGL_CONFIGS_FILE_NAME}" "cfg/*.cfg" && mv "cfg/"* "${SERVER_DIR}/tf/cfg/" \
  && unzip -q "${IMPROVED_MATCH_TIMER_PLUGIN_FILE_NAME}" \
    && mv "Improved-Match-Timer-main/addons/sourcemod/plugins/"*.smx "${SERVER_DIR}/tf/addons/sourcemod/plugins/" \
    && mv "Improved-Match-Timer-main/addons/sourcemod/scripting/"*.sp "${SERVER_DIR}/tf/addons/sourcemod/scripting/" \
  && mv "${CURL_EXTENSION_FILE_NAME}" "${SERVER_DIR}/tf/addons/sourcemod/extensions/${CURL_EXTENSION_FILE_NAME}" \
  && mv "${DEMOS_TF_PLUGIN_FILE_NAME}" "${SERVER_DIR}/tf/addons/sourcemod/plugins/${DEMOS_TF_PLUGIN_FILE_NAME}" \
  && mv "${SRCTV_PLUS_SO_FILE_NAME}" "${SERVER_DIR}/tf/addons/${SRCTV_PLUS_SO_FILE_NAME}" \
  && mv "${SRCTV_PLUS_VDF_FILE_NAME}" "${SERVER_DIR}/tf/addons/${SRCTV_PLUS_VDF_FILE_NAME}" \
  && unzip -q "${SUPSTATS2_PLUGIN_FILE_NAME}" -d "${SERVER_DIR}/tf/addons/sourcemod/plugins/" \
  && unzip -q "${MEDIC_STATS_PLUGIN_FILE_NAME}" -d "${SERVER_DIR}/tf/addons/sourcemod/plugins/" \
  && unzip -q "${RESTORE_SCORE_PLUGIN_FILE_NAME}" -d "${SERVER_DIR}/tf/addons/sourcemod/plugins/" \
  && unzip -q "${LOGSTF_PLUGIN_FILE_NAME}" -d "${SERVER_DIR}/tf/addons/sourcemod/plugins/" \
  && unzip -q "${RECORD_STV_PLUGIN_FILE_NAME}" -d "${SERVER_DIR}/tf/addons/sourcemod/plugins/" \
  && unzip -q "${WAIT_FOR_STV_PLUGIN_FILE_NAME}" -d "${SERVER_DIR}/tf/addons/sourcemod/plugins/" \
  && unzip -q "${FIX_STV_SLOT_PLUGIN_FILE_NAME}" -d "${SERVER_DIR}/tf/addons/sourcemod/plugins/" \
  && unzip -q "${AFK_PLUGIN_FILE_NAME}" -d "${SERVER_DIR}/tf/addons/sourcemod/plugins/" \
  # cleanup
  && rm "${SOAP_DM_PLUGIN_FILE_NAME}" \
  && rm "${DHOOKS_PLUGIN_FILE_NAME}" \
  && rm "${COMP_FIXES_PLUGIN_FILE_NAME}" \
  && rm "${UPDATED_PAUSE_PLUGIN_FILE_NAME}" \
  && rm -r "MGEMod-master" "${MGEMOD_PLUGIN_FILE_NAME}" \
  && rm "${CURL_PLUGIN_FILE_NAME}" \
  && rm "${ETF2L_CONFIGS_FILE_NAME}" \
  && rm -r "${RGL_CONFIGS_FILE_NAME}" "cfg" \
  && rm -r "${IMPROVED_MATCH_TIMER_PLUGIN_FILE_NAME}" "Improved-Match-Timer-main" \
  && rm "${SUPSTATS2_PLUGIN_FILE_NAME}" "${MEDIC_STATS_PLUGIN_FILE_NAME}" "${RESTORE_SCORE_PLUGIN_FILE_NAME}" "${LOGSTF_PLUGIN_FILE_NAME}" \
    "${RECORD_STV_PLUGIN_FILE_NAME}" "${WAIT_FOR_STV_PLUGIN_FILE_NAME}" "${FIX_STV_SLOT_PLUGIN_FILE_NAME}" "${AFK_PLUGIN_FILE_NAME}" \
  && rm "checksum.md5" \
  # remove useless (and potentially harmful) plugins
  && rm "$SERVER_DIR/tf/addons/sourcemod/plugins/"{nextmap,funcommands,funvotes}.smx


ENV DEMOS_TF_APIKEY=
ENV LOGS_TF_APIKEY=

COPY cfg/* ${SERVER_DIR}/tf/cfg/

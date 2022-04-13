FROM melkortf/tf2-tftrue:latest
LABEL maintainer="garrappachc@gmail.com"

COPY checksum.md5 .

ARG SOAP_DM_PLUGIN_FILE_NAME=soap.zip
ARG SOAP_DM_PLUGIN_URL=https://github.com/sapphonie/SOAP-TF2DM/releases/download/v4.4.1/${SOAP_DM_PLUGIN_FILE_NAME}

ARG DHOOKS_PLUGIN_FILE_NAME=dhooks-2.2.0-detours17-sm110.zip
ARG DHOOKS_PLUGIN_URL=https://github.com/peace-maker/DHooks2/releases/download/v2.2.0-detours17/${DHOOKS_PLUGIN_FILE_NAME}

ARG COMP_FIXES_PLUGIN_FILE_NAME=tf2-comp-fixes.zip
ARG COMP_FIXES_PLUGIN_URL=https://github.com/ldesgoui/tf2-comp-fixes/releases/download/v1.16.6/${COMP_FIXES_PLUGIN_FILE_NAME}

ARG UPDATED_PAUSE_PLUGIN_FILE_NAME=updated-pause-plugin.zip
ARG UPDATED_PAUSE_PLUGIN_URL=https://github.com/l-Aad-l/updated-pause-plugin/releases/download/v1.4.2/${UPDATED_PAUSE_PLUGIN_FILE_NAME}

ARG MGEMOD_PLUGIN_FILE_NAME=mgemod.zip
ARG MGEMOD_PLUGIN_URL=https://github.com/sapphonie/MGEMod/archive/master.zip

ARG CURL_PLUGIN_FILE_NAME=curl_1.3.0.0.zip
ARG CURL_PLUGIN_URL=https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/sourcemod-curl-extension/${CURL_PLUGIN_FILE_NAME}
ARG CURL_EXTENSION_FILE_NAME=curl.ext.so
ARG CURL_EXTENSION_URL=https://raw.githubusercontent.com/spiretf/docker-comp-server/master/${CURL_EXTENSION_FILE_NAME}

ARG ETF2L_CONFIGS_FILE_NAME=etf2l_configs.zip
ARG ETF2L_CONFIGS_URL=https://github.com/ETF2L/gameserver-configs/releases/download/1.0.2/${ETF2L_CONFIGS_FILE_NAME}

ARG RGL_CONFIGS_FILE_NAME=rgl_configs.zip
ARG RGL_CONFIGS_URL=https://github.com/RGLgg/server-resources-updater/archive/master.zip

ARG DEMOS_TF_PLUGIN_FILE_NAME=demostf.smx
ARG DEMOS_TF_PLUGIN_URL=https://github.com/demostf/plugin/raw/master/${DEMOS_TF_PLUGIN_FILE_NAME}

ARG SRCTV_PLUS_SO_FILE_NAME=srctvplus.so
ARG SRCTV_PLUS_SO_URL=https://github.com/dalegaard/srctvplus/releases/download/v1.1/${SRCTV_PLUS_SO_FILE_NAME}

ARG SRCTV_PLUS_VDF_FILE_NAME=srctvplus.vdf
ARG SRCTV_PLUS_VDF_URL=https://github.com/dalegaard/srctvplus/releases/download/v1.1/${SRCTV_PLUS_VDF_FILE_NAME}

ARG ROUNDTIMER_OVERRIDE_PLUGIN_FILE_NAME=roundtimeroverride.zip
ARG ROUNDTIMER_OVERRIDE_PLUGIN_URL=https://github.com/b4nnyBot/TF2-Improved-Round-Timer-Plugin/raw/main/Round%20Timer%20Override%20Plugin.zip

RUN \
  # download all the plugins
  wget -nv "${SOAP_DM_PLUGIN_URL}" "${DHOOKS_PLUGIN_URL}" "${COMP_FIXES_PLUGIN_URL}" "${UPDATED_PAUSE_PLUGIN_URL}" "${CURL_PLUGIN_URL}" "${CURL_EXTENSION_URL}" \
    "${ETF2L_CONFIGS_URL}" "${DEMOS_TF_PLUGIN_URL}" "${SRCTV_PLUS_SO_URL}" "${SRCTV_PLUS_VDF_URL}" \
  && wget -nv "${MGEMOD_PLUGIN_URL}" -O "${MGEMOD_PLUGIN_FILE_NAME}" \
  && wget -nv "${RGL_CONFIGS_URL}" -O "${RGL_CONFIGS_FILE_NAME}" \
  && wget -nv "${ROUNDTIMER_OVERRIDE_PLUGIN_URL}" -O "${ROUNDTIMER_OVERRIDE_PLUGIN_FILE_NAME}" \
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
  && unzip -q "${RGL_CONFIGS_FILE_NAME}" "server-resources-updater-master/cfg/*.cfg" && mv "server-resources-updater-master/cfg/"* "${SERVER_DIR}/tf/cfg/" \
  && unzip -q "${ROUNDTIMER_OVERRIDE_PLUGIN_FILE_NAME}"\
    && mv roundtimer_override.smx "${SERVER_DIR}/tf/addons/sourcemod/plugins/" \
    && mv roundtimer_override.sp "${SERVER_DIR}/tf/addons/sourcemod/scripting/" \
  && mv "${CURL_EXTENSION_FILE_NAME}" "${SERVER_DIR}/tf/addons/sourcemod/extensions/${CURL_EXTENSION_FILE_NAME}" \
  && mv "${DEMOS_TF_PLUGIN_FILE_NAME}" "${SERVER_DIR}/tf/addons/sourcemod/plugins/${DEMOS_TF_PLUGIN_FILE_NAME}" \
  && mv "${SRCTV_PLUS_SO_FILE_NAME}" "${SERVER_DIR}/tf/addons/${SRCTV_PLUS_SO_FILE_NAME}" \
  && mv "${SRCTV_PLUS_VDF_FILE_NAME}" "${SERVER_DIR}/tf/addons/${SRCTV_PLUS_VDF_FILE_NAME}" \
  # cleanup
  && rm "${SOAP_DM_PLUGIN_FILE_NAME}" \
  && rm "${DHOOKS_PLUGIN_FILE_NAME}" \
  && rm "${COMP_FIXES_PLUGIN_FILE_NAME}" \
  && rm "${UPDATED_PAUSE_PLUGIN_FILE_NAME}" \
  && rm -r "MGEMod-master" "${MGEMOD_PLUGIN_FILE_NAME}" \
  && rm "${CURL_PLUGIN_FILE_NAME}" \
  && rm "${ETF2L_CONFIGS_FILE_NAME}" \
  && rm -r "${RGL_CONFIGS_FILE_NAME}" "server-resources-updater-master" \
  && rm "${ROUNDTIMER_OVERRIDE_PLUGIN_FILE_NAME}" \
  && rm "checksum.md5" \
  # remove useless (and potentially harmful) plugins
  && rm "$SERVER_DIR/tf/addons/sourcemod/plugins/"{nextmap,funcommands,funvotes}.smx


ENV DEMOS_TF_APIKEY=

COPY cfg/* ${SERVER_DIR}/tf/cfg/

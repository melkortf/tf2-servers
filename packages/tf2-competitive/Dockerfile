FROM melkortf/tf2-tftrue:latest
LABEL maintainer="garrappachc@gmail.com"

COPY checksum.md5 .

RUN rm "$SERVER_DIR/tf/addons/sourcemod/plugins/"{nextmap,funcommands,funvotes}.smx

RUN \
  # download all the plugins
  SOAP_DM_FILE_NAME="soap.zip" \
  && wget -nv "https://github.com/sapphonie/SOAP-TF2DM/releases/download/v4.4.1/${SOAP_DM_FILE_NAME}" \
  && DHOOKS_FILE_NAME="dhooks-2.2.0-detours16-sm110.zip" \
  && wget -nv "https://github.com/peace-maker/DHooks2/releases/download/v2.2.0-detours16/${DHOOKS_FILE_NAME}" \
  && COMP_FIXES_FILE_NAME="tf2-comp-fixes.zip" \
  && wget -nv "https://github.com/ldesgoui/tf2-comp-fixes/releases/download/v1.13.0/${COMP_FIXES_FILE_NAME}" \
  && UPDATED_PAUSE_PLUGIN_FILE_NAME="updated-pause-plugin.zip" \
  && wget -nv "https://github.com/l-Aad-l/updated-pause-plugin/releases/download/v1.4.2/${UPDATED_PAUSE_PLUGIN_FILE_NAME}" \
  && wget -nv "https://github.com/sapphonie/MGEMod/archive/master.zip" -O "mgemod.zip" \
  && CURL_FILE_NAME="curl_1.3.0.0.zip" \
  && wget -nv "https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/sourcemod-curl-extension/${CURL_FILE_NAME}" \
  && ETF2L_CONFIGS_FILE_NAME="etf2l_configs.zip" \
  && wget -nv "http://etf2l.org/configs/${ETF2L_CONFIGS_FILE_NAME}" \ 
  && RGL_CONFIGS_FILE_NAME="rgl_configs.zip" \
  && wget -nv "https://github.com/RGLgg/server-resources-updater/archive/master.zip" -O "${RGL_CONFIGS_FILE_NAME}" \
  && wget -nv "https://raw.githubusercontent.com/spiretf/docker-comp-server/master/curl.ext.so" \
  && wget -nv "https://github.com/demostf/plugin/raw/master/demostf.smx" \
  && wget -nv "https://github.com/dalegaard/srctvplus/releases/download/v1.1/srctvplus.so" \
  && wget -nv "https://github.com/dalegaard/srctvplus/releases/download/v1.1/srctvplus.vdf" \
  # verify md5 checksums
  && md5sum -c checksum.md5 \
  # install plugins
  && unzip -q "${SOAP_DM_FILE_NAME}" -d "${SERVER_DIR}/tf/" \
  && unzip -q "${DHOOKS_FILE_NAME}" -d "${SERVER_DIR}/tf/" \
  && unzip -q -o "${COMP_FIXES_FILE_NAME}" -d "${SERVER_DIR}/tf/" \
  && unzip -q -o "${UPDATED_PAUSE_PLUGIN_FILE_NAME}" -d "${SERVER_DIR}/tf/" \
  && unzip -q "mgemod.zip" && cp -r "MGEMod-master/addons" "${SERVER_DIR}/tf/" \
  && unzip -q -o "${CURL_FILE_NAME}" -d "${SERVER_DIR}/tf/addons/sourcemod" \
  && unzip -q "${ETF2L_CONFIGS_FILE_NAME}" -d "${SERVER_DIR}/tf/cfg/" \
  && unzip -q "${RGL_CONFIGS_FILE_NAME}" "server-resources-updater-master/cfg/*.cfg" && mv "server-resources-updater-master/cfg/"* "${SERVER_DIR}/tf/cfg/" \
  && mv "curl.ext.so" "${SERVER_DIR}/tf/addons/sourcemod/extensions/curl.ext.so" \
  && mv "demostf.smx" "${SERVER_DIR}/tf/addons/sourcemod/plugins/demostf.smx" \
  && mv "srctvplus.so" "${SERVER_DIR}/tf/addons/srctvplus.so" \
  && mv "srctvplus.vdf" "${SERVER_DIR}/tf/addons/srctvplus.vdf" \
  # cleanup
  && rm "${SOAP_DM_FILE_NAME}" \
  && rm "${DHOOKS_FILE_NAME}" \
  && rm "${COMP_FIXES_FILE_NAME}" \
  && rm "${UPDATED_PAUSE_PLUGIN_FILE_NAME}" \
  && rm -r "MGEMod-master" "mgemod.zip" \
  && rm "${CURL_FILE_NAME}" \
  && rm "${ETF2L_CONFIGS_FILE_NAME}" \
  && rm -r "${RGL_CONFIGS_FILE_NAME}" "server-resources-updater-master" \
  && rm "checksum.md5"

ENV DEMOS_TF_APIKEY=

COPY server.cfg.template ${SERVER_DIR}/tf/cfg/server.cfg.template

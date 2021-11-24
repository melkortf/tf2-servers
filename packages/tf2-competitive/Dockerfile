FROM melkortf/tf2-tftrue:latest
LABEL maintainer="garrappachc@gmail.com"

RUN rm $SERVER_DIR/tf/addons/sourcemod/plugins/{nextmap,funcommands,funvotes}.smx

RUN wget -nv "https://github.com/spiretf/SOAP-TF2DM/archive/master.zip" -O "soap-dm.zip" \
  && unzip "soap-dm.zip" \
  && cp -r SOAP-TF2DM-master/* "${SERVER_DIR}/tf/" \
  && rm -rf "SOAP-TF2DM-master" "soap-dm.zip"

RUN DHOOKS_FILE_NAME="dhooks-2.2.0-detours16-sm110.zip" \
  && wget -nv "https://github.com/peace-maker/DHooks2/releases/download/v2.2.0-detours16/${DHOOKS_FILE_NAME}" \
  && unzip "${DHOOKS_FILE_NAME}" -d "${SERVER_DIR}/tf/" \
  && rm -f "${DHOOKS_FILE_NAME}"

RUN COMP_FIXES_FILE_NAME="tf2-comp-fixes.zip" \
  && wget -nv "https://github.com/ldesgoui/tf2-comp-fixes/releases/download/v1.11.2/${COMP_FIXES_FILE_NAME}" \
  && unzip -o "${COMP_FIXES_FILE_NAME}" -d "${SERVER_DIR}/tf/" \
  && rm -f "${COMP_FIXES_FILE_NAME}"

RUN UPDATED_PAUSE_PLUGIN_FILE_NAME="updated-pause-plugin.zip" \
  && wget -nv "https://github.com/l-Aad-l/updated-pause-plugin/releases/download/v1.4.2/${UPDATED_PAUSE_PLUGIN_FILE_NAME}" \
  && unzip -o "${UPDATED_PAUSE_PLUGIN_FILE_NAME}" -d "${SERVER_DIR}/tf/" \
  && rm -f "${UPDATED_PAUSE_PLUGIN_FILE_NAME}"

RUN wget -nv "https://github.com/sapphonie/MGEMod/archive/master.zip" -O "mgemod.zip" \
  && unzip "mgemod.zip" \
  && cp -r "MGEMod-master/addons" "${SERVER_DIR}/tf/" \
  && rm -rf "MGEMod-master" "mgemod.zip"

RUN CURL_FILE_NAME="curl_1.3.0.0.zip" \
  && wget -nv "https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/sourcemod-curl-extension/${CURL_FILE_NAME}" \
  && unzip -o "${CURL_FILE_NAME}" -d "${SERVER_DIR}/tf/addons/sourcemod" \
  && rm -f "${CURL_FILE_NAME}" \
  && wget https://raw.githubusercontent.com/spiretf/docker-comp-server/master/curl.ext.so -O "${SERVER_DIR}/tf/addons/sourcemod/extensions/curl.ext.so"

RUN wget -nv https://github.com/demostf/plugin/raw/master/demostf.smx -O $SERVER_DIR/tf/addons/sourcemod/plugins/demostf.smx

RUN ETF2L_CONFIGS_FILE_NAME="etf2l_configs.zip" \
  && wget -nv "http://etf2l.org/configs/${ETF2L_CONFIGS_FILE_NAME}" \ 
  && unzip "${ETF2L_CONFIGS_FILE_NAME}" -d "${SERVER_DIR}/tf/cfg/" \
  && rm -f "${ETF2L_CONFIGS_FILE_NAME}"

RUN RGL_CONFIGS_FILE_NAME="rgl_configs.zip" \
  && wget -nv "https://github.com/RGLgg/server-resources-updater/archive/master.zip" -O "${RGL_CONFIGS_FILE_NAME}" \ 
  && unzip "${RGL_CONFIGS_FILE_NAME}" "server-resources-updater-master/cfg/*.cfg" \
  && mv server-resources-updater-master/cfg/* "tf/cfg/" \
  && rm -rf "${RGL_CONFIGS_FILE_NAME}" "server-resources-updater-master/"

RUN wget -nv "https://github.com/dalegaard/srctvplus/releases/download/v1.1/srctvplus.so" -O "${SERVER_DIR}/tf/addons/srctvplus.so" \
  && wget -nv "https://github.com/dalegaard/srctvplus/releases/download/v1.1/srctvplus.vdf" -O "${SERVER_DIR}/tf/addons/srctvplus.vdf"

WORKDIR $SERVER_DIR

ENV DEMOS_TF_APIKEY=

COPY server.cfg.template ${SERVER_DIR}/tf/cfg/server.cfg.template

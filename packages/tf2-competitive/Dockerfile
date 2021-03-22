FROM melkortf/tf2-tftrue:latest
LABEL maintainer="garrappachc@gmail.com"

RUN rm $SERVER_DIR/tf/addons/sourcemod/plugins/{nextmap,funcommands,funvotes}.smx

WORKDIR $SERVER_DIR/tf
RUN wget -nv "https://github.com/spiretf/SOAP-TF2DM/archive/master.zip" -O "soap-dm.zip" \
  && unzip soap-dm.zip \
  && cp -r SOAP-TF2DM-master/* ./ \
  && rm -rf SOAP-TF2DM-master \
  && rm -f soap-dm.zip

RUN DHOOKS_FILE_NAME="dhooks-2.2.0-detours16-sm110.zip" \
  && wget -nv https://github.com/peace-maker/DHooks2/releases/download/v2.2.0-detours16/${DHOOKS_FILE_NAME} \
  && unzip ${DHOOKS_FILE_NAME} \
  && rm -f ${DHOOKS_FILE_NAME}

RUN COMP_FIXES_FILE_NAME="tf2-comp-fixes.zip" \
  && wget -nv https://github.com/ldesgoui/tf2-comp-fixes/releases/download/v1.10.5/${COMP_FIXES_FILE_NAME} \
  && unzip -o ${COMP_FIXES_FILE_NAME} \
  && rm -f ${COMP_FIXES_FILE_NAME}

RUN UPDATED_PAUSE_PLUGIN_FILE_NAME="updated-pause-plugin.zip" \
  && wget -nv https://github.com/l-Aad-l/updated-pause-plugin/releases/download/v1.4.2/${UPDATED_PAUSE_PLUGIN_FILE_NAME} \
  && unzip -o ${UPDATED_PAUSE_PLUGIN_FILE_NAME} \
  && rm -f ${UPDATED_PAUSE_PLUGIN_FILE_NAME}

WORKDIR $SERVER_DIR/tf/addons/sourcemod

RUN CURL_FILE_NAME="curl_1.3.0.0.zip" \
  && wget -nv "https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/sourcemod-curl-extension/${CURL_FILE_NAME}" \
  && unzip -o ${CURL_FILE_NAME} \
  && rm -f ${CURL_FILE_NAME} \
  && wget https://raw.githubusercontent.com/spiretf/docker-comp-server/master/curl.ext.so -O $SERVER_DIR/tf/addons/sourcemod/extensions/curl.ext.so

RUN wget -nv https://github.com/demostf/plugin/raw/master/demostf.smx -O $SERVER_DIR/tf/addons/sourcemod/plugins/demostf.smx

WORKDIR $SERVER_DIR/tf/cfg

RUN ETF2L_CONFIGS_FILE_NAME="etf2l_configs.zip" \
  && wget -nv "http://etf2l.org/configs/${ETF2L_CONFIGS_FILE_NAME}" \ 
  && unzip ${ETF2L_CONFIGS_FILE_NAME} \
  && rm -f ${ETF2L_CONFIGS_FILE_NAME}

WORKDIR $SERVER_DIR

ENV DEMOS_TF_APIKEY=

COPY server.cfg.template ${SERVER_DIR}/tf/cfg/server.cfg.template

FROM melkortf/tf2-sourcemod:latest
LABEL maintainer="garrappachc@gmail.com"

RUN rm $SERVER_DIR/tf/addons/sourcemod/plugins/{funcommands,funvotes}.smx

RUN wget -nv "https://github.com/spiretf/SOAP-TF2DM/archive/master.zip" -O "soap-dm.zip" \
  && unzip "soap-dm.zip" \
  && cp -r "SOAP-TF2DM-master/"* "${SERVER_DIR}/tf/" \
  && rm -rf "SOAP-TF2DM-master" "soap-dm.zip"

RUN DHOOKS_FILE_NAME="dhooks-2.2.0-detours16-sm110.zip" \
  && wget -nv "https://github.com/peace-maker/DHooks2/releases/download/v2.2.0-detours16/${DHOOKS_FILE_NAME}" \
  && unzip "${DHOOKS_FILE_NAME}" -d "${SERVER_DIR}/tf/" \
  && rm -f "${DHOOKS_FILE_NAME}"

RUN COMP_FIXES_FILE_NAME="tf2-comp-fixes.zip" \
  && wget -nv "https://github.com/ldesgoui/tf2-comp-fixes/releases/download/v1.10.5/${COMP_FIXES_FILE_NAME}" \
  && unzip -o "${COMP_FIXES_FILE_NAME}" -d "${SERVER_DIR}/tf/" \
  && rm -f "${COMP_FIXES_FILE_NAME}"

RUN wget -nv "https://www.sourcemod.net/vbcompiler.php?file_id=27957" -O "${SERVER_DIR}/tf/addons/sourcemod/plugins/classrestrict.smx"

COPY server.cfg.template "${SERVER_DIR}/tf/cfg/server.cfg.template"
COPY soap_tf2dm.cfg "${SERVER_DIR}/tf/cfg/sourcemod/soap_tf2dm.cfg"
COPY mapcycle.txt "${SERVER_DIR}/tf/cfg/mapcycle.txt"

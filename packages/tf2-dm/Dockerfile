FROM melkortf/tf2-tftrue:latest
LABEL maintainer="garrappachc@gmail.com"

COPY checksum.md5 .

RUN rm "${SERVER_DIR}/tf/addons/sourcemod/plugins/"{funcommands,funvotes}.smx

RUN \
  # download plugins
  SOAP_DM_FILE_NAME="soap-dm.zip" \
  && wget -nv "https://github.com/sapphonie/SOAP-TF2DM/archive/master.zip" -O "${SOAP_DM_FILE_NAME}" \
  && DHOOKS_FILE_NAME="dhooks-2.2.0-detours17-sm110.zip" \
  && wget -nv "https://github.com/peace-maker/DHooks2/releases/download/v2.2.0-detours17/${DHOOKS_FILE_NAME}" \
  && COMP_FIXES_FILE_NAME="tf2-comp-fixes.zip" \
  && wget -nv "https://github.com/ldesgoui/tf2-comp-fixes/releases/download/v1.16.2/${COMP_FIXES_FILE_NAME}" \
  && wget -nv "https://www.sourcemod.net/vbcompiler.php?file_id=27957" -O "classrestrict.smx" \
  && wget -nv "https://www.sourcemod.net/vbcompiler.php?file_id=170330" -O "afk_manager4.smx" \
  && wget -nv "https://forums.alliedmods.net/attachment.php?attachmentid=166646&d=1510967008" -O "afk_manager.phrases.txt" \
  && SOURCEBANS_FILE_NAME="sourcebans-pp-1.6.4.plugin-only.tar.gz" \
  && wget -nv "https://github.com/sbpp/sourcebans-pp/releases/download/1.6.4/${SOURCEBANS_FILE_NAME}" \
  # verify checksums
  && md5sum -c checksum.md5 \
  # install plugins
  && unzip -q "${SOAP_DM_FILE_NAME}" \
  && cp -r "SOAP-TF2DM-master/"* "${SERVER_DIR}/tf/" \
  && unzip -q -o "${DHOOKS_FILE_NAME}" -d "${SERVER_DIR}/tf/" \
  && unzip -q -o "${COMP_FIXES_FILE_NAME}" -d "${SERVER_DIR}/tf/" \
  && mv "classrestrict.smx" "${SERVER_DIR}/tf/addons/sourcemod/plugins/classrestrict.smx" \
  && mv "afk_manager4.smx" "${SERVER_DIR}/tf/addons/sourcemod/plugins/afk_manager4.smx" \
  && mv "afk_manager.phrases.txt" "${SERVER_DIR}/tf/addons/sourcemod/translations/afk_manager.phrases.txt" \
  && tar xf "${SOURCEBANS_FILE_NAME}" -C "${SERVER_DIR}/tf" --strip-components=1 \
  # clean everything up
  && rm -r "SOAP-TF2DM-master" "${SOAP_DM_FILE_NAME}" \
  && rm "${DHOOKS_FILE_NAME}" \
  && rm "${COMP_FIXES_FILE_NAME}" \
  && rm "${SOURCEBANS_FILE_NAME}" \
  && rm "checksum.md5"

COPY server.cfg.template "${SERVER_DIR}/tf/cfg/server.cfg.template"
COPY soap_tf2dm.cfg "${SERVER_DIR}/tf/cfg/sourcemod/soap_tf2dm.cfg"
COPY mapcycle.txt "${SERVER_DIR}/tf/cfg/mapcycle.txt"
COPY afk_manager.cfg "${SERVER_DIR}/tf/cfg/sourcemod/afk_manager.cfg"
COPY custom_whitelist_11769.txt "${SERVER_DIR}/tf/cfg/custom_whitelist_11769.txt"

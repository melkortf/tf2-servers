ARG REGISTRY=ghcr.io
ARG TF2_SOURCEMOD_TAG=latest
FROM ${REGISTRY}/melkortf/tf2-sourcemod/i386:${TF2_SOURCEMOD_TAG}
LABEL maintainer="garrappachc@gmail.com"

COPY checksum.md5 .

ARG SOAP_DM_PLUGIN_FILE_NAME=soap.zip
ARG SOAP_DM_PLUGIN_VERSION=4.4.6
ARG SOAP_DM_PLUGIN_URL=https://github.com/sapphonie/SOAP-TF2DM/releases/download/v${SOAP_DM_PLUGIN_VERSION}/${SOAP_DM_PLUGIN_FILE_NAME}

ARG COMP_FIXES_PLUGIN_FILE_NAME=tf2-comp-fixes.zip
ARG COMP_FIXES_PLUGIN_VERSION=1.16.14
ARG COMP_FIXES_PLUGIN_URL=https://github.com/ldesgoui/tf2-comp-fixes/releases/download/v${COMP_FIXES_PLUGIN_VERSION}/${COMP_FIXES_PLUGIN_FILE_NAME}

ARG CLASS_RESTRICT_PLUGIN_FILE_NAME=classrestrict.smx
ARG CLASS_RESTRICT_PLUGIN_URL=https://www.sourcemod.net/vbcompiler.php?file_id=27957

ARG AFK_MANAGER_PLUGIN_FILE_NAME=afk_manager4.smx
ARG AFK_MANAGER_PLUGIN_URL=https://www.sourcemod.net/vbcompiler.php?file_id=170330

ARG SOURCEBANS_PLUGIN_FILE_NAME=sourcebans-pp-1.6.4.plugin-only.tar.gz
ARG SOURCEBANS_PLUGIN_URL=https://github.com/sbpp/sourcebans-pp/releases/download/1.6.4/${SOURCEBANS_PLUGIN_FILE_NAME}

ARG TF2RUE_PLUGIN_FILE_NAME=tf2rue.zip
ARG TF2RUE_PLUGIN_VERSION=v0.0.12
ARG TF2RUE_PLUGIN_URL=https://github.com/sapphonie/tf2rue/releases/download/${TF2RUE_PLUGIN_VERSION}/${TF2RUE_PLUGIN_FILE_NAME}

RUN \
  # download plugins
  wget -nv "${SOAP_DM_PLUGIN_URL}" "${COMP_FIXES_PLUGIN_URL}" "${SOURCEBANS_PLUGIN_URL}" "${TF2RUE_PLUGIN_URL}" \
  && wget -nv "${CLASS_RESTRICT_PLUGIN_URL}" -O "${CLASS_RESTRICT_PLUGIN_FILE_NAME}" \
  && wget -nv "${AFK_MANAGER_PLUGIN_URL}" -O "${AFK_MANAGER_PLUGIN_FILE_NAME}" \
  # verify checksums
  && md5sum -c checksum.md5 \
  # install plugins
  && unzip -q "${SOAP_DM_PLUGIN_FILE_NAME}" -d "${SERVER_DIR}/tf/" \
  && unzip -q -o "${COMP_FIXES_PLUGIN_FILE_NAME}" -d "${SERVER_DIR}/tf/" \
  && unzip -q -n "${TF2RUE_PLUGIN_FILE_NAME}" -d "${SERVER_DIR}/tf/addons/sourcemod/" \
  && mv "${CLASS_RESTRICT_PLUGIN_FILE_NAME}" "${SERVER_DIR}/tf/addons/sourcemod/plugins/${CLASS_RESTRICT_PLUGIN_FILE_NAME}" \
  && mv "${AFK_MANAGER_PLUGIN_FILE_NAME}" "${SERVER_DIR}/tf/addons/sourcemod/plugins/${AFK_MANAGER_PLUGIN_FILE_NAME}" \
  && tar xf "${SOURCEBANS_PLUGIN_FILE_NAME}" -C "${SERVER_DIR}/tf" \
  # clean everything up
  && rm "${SOAP_DM_PLUGIN_FILE_NAME}" "${COMP_FIXES_PLUGIN_FILE_NAME}" "${SOURCEBANS_PLUGIN_FILE_NAME}" "${TF2RUE_PLUGIN_FILE_NAME}" \
  && rm "checksum.md5" \
  # remove unused plugins
  && rm "${SERVER_DIR}/tf/addons/sourcemod/plugins/"{funcommands,funvotes}.smx

COPY server.cfg.template "${SERVER_DIR}/tf/cfg/server.cfg.template"
COPY soap_tf2dm.cfg "${SERVER_DIR}/tf/cfg/sourcemod/soap_tf2dm.cfg"
COPY mapcycle.txt "${SERVER_DIR}/tf/cfg/mapcycle.txt"
COPY afk_manager.cfg "${SERVER_DIR}/tf/cfg/sourcemod/afk_manager.cfg"
COPY custom_whitelist_11769.txt "${SERVER_DIR}/tf/cfg/custom_whitelist_11769.txt"
COPY afk_manager.phrases.txt "${SERVER_DIR}/tf/addons/sourcemod/translations/afk_manager.phrases.txt"

CMD ["+sv_pure", "2", "+map", "cp_badlands", "+maxplayers", "8"]

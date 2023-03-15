ARG REGISTRY=ghcr.io
ARG TF2_SOURCEMOD_TAG=latest
FROM ${REGISTRY}/melkortf/tf2-sourcemod:${TF2_SOURCEMOD_TAG}
LABEL maintainer="garrappachc@gmail.com"

COPY checksum.md5 .

RUN rm "${SERVER_DIR}/tf/addons/sourcemod/plugins/"{funcommands,funvotes}.smx

RUN \
  # download plugins
  wget -nv "https://github.com/sapphonie/MGEMod/archive/master.zip" -O "mgemod.zip" \
  && SOURCEBANS_FILE_NAME="sourcebans-pp-1.6.4.plugin-only.tar.gz" \
  && wget -nv "https://github.com/sbpp/sourcebans-pp/releases/download/1.6.4/${SOURCEBANS_FILE_NAME}" \
  && wget -nv "https://www.sourcemod.net/vbcompiler.php?file_id=170330" -O "afk_manager4.smx" \
  && wget -nv "https://forums.alliedmods.net/attachment.php?attachmentid=166646&d=1510967008" -O "afk_manager.phrases.txt" \
  # verify checksums
  && md5sum -c checksum.md5 \
  # install plugins
  && unzip -q "mgemod.zip" && cp -r "MGEMod-master/addons" "${SERVER_DIR}/tf/" \
  && tar xf "${SOURCEBANS_FILE_NAME}" -C "${SERVER_DIR}/tf" \
  && mv "afk_manager4.smx" "${SERVER_DIR}/tf/addons/sourcemod/plugins/afk_manager4.smx" \
  && mv "afk_manager.phrases.txt" "${SERVER_DIR}/tf/addons/sourcemod/translations/afk_manager.phrases.txt" \
  # cleanup
  && rm -r "MGEMod-master" "mgemod.zip" \
  && rm "${SOURCEBANS_FILE_NAME}" \
  && rm "checksum.md5"

ENV SELECTED_MAP="mge_training_v8_beta4b"

COPY server.cfg.template "${SERVER_DIR}/tf/cfg/server.cfg.template"
COPY mapcycle.txt.template "${SERVER_DIR}/tf/cfg/mapcycle.txt.template"
COPY afk_manager.cfg "${SERVER_DIR}/tf/cfg/sourcemod/afk_manager.cfg"

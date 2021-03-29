FROM melkortf/tf2-sourcemod
LABEL maintainer="garrappachc@gmail.com"

RUN rm $SERVER_DIR/tf/addons/sourcemod/plugins/{nextmap,funcommands,funvotes}.smx

RUN wget -nv "https://github.com/sapphonie/MGEMod/archive/master.zip" -O "mgemod.zip" \
  && unzip mgemod.zip \
  && cp -r MGEMod-master/addons "$SERVER_DIR/tf/" \
  && rm -rf MGEMod-master \
  && rm -f mgemod.zip \
  && wget -nv "https://www.sourcemod.net/vbcompiler.php?file_id=170330" -O "${SERVER_DIR}/tf/addons/sourcemod/plugins/afk_manager4.smx" \
  && wget -nv "https://forums.alliedmods.net/attachment.php?attachmentid=166646&d=1510967008" -O "${SERVER_DIR}/tf/addons/sourcemod/translations/afk_manager.phrases.txt" \
  && wget -nv "https://github.com/sbpp/sourcebans-pp/releases/download/1.6.3/sourcebans-pp-1.6.3.plugin-only.tar.gz" \
  && tar xf "sourcebans-pp-1.6.3.plugin-only.tar.gz" -C "${SERVER_DIR}/tf" --strip-components=1 \
  && rm -rf "sourcebans-pp-1.6.3.plugin-only.tar.gz"

COPY server.cfg.template "${SERVER_DIR}/tf/cfg/server.cfg.template"
COPY afk_manager.cfg "${SERVER_DIR}/tf/cfg/sourcemod/afk_manager.cfg"

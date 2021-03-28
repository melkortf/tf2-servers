FROM melkortf/tf2-sourcemod
LABEL maintainer="garrappachc@gmail.com"

RUN rm $SERVER_DIR/tf/addons/sourcemod/plugins/{nextmap,funcommands,funvotes}.smx

RUN wget -nv "https://github.com/sapphonie/MGEMod/archive/master.zip" -O "mgemod.zip" \
  && unzip mgemod.zip \
  && cp -r MGEMod-master/addons $SERVER_DIR/tf/ \
  && rm -rf MGEMod-master \
  && rm -f mgemod.zip

FROM steamcmd/steamcmd:latest
LABEL maintainer="garrappachc@gmail.com"

RUN env DEBIAN_FRONTEND=noninteractive \
  && dpkg --add-architecture i386 \
  && apt-get -y update \
  && apt-get install -y software-properties-common \
  && add-apt-repository multiverse \
  && apt-get -y update \
  && apt-get install -y --no-install-recommends --no-install-suggests \
    lib32gcc1 \
    lib32z1 \
    libncurses5:i386 \
    libbz2-1.0:i386 \
    lib32gcc1 \
    lib32stdc++6 \
    libtinfo5:i386 \
    libcurl3-gnutls:i386 \
  && rm -rf /var/lib/apt/lists/*

ARG USER=tf2
ARG HOME=/home/$USER
ARG SERVER_DIR=$HOME/server
ARG APP_ID=232250

ENV USER=$USER
ENV HOME=$HOME
ENV SERVER_DIR=$SERVER_DIR
ENV APP_ID=$APP_ID

ENV IP=0.0.0.0
ENV PORT=27015
ENV CLIENTPORT=27016
ENV STEAMPORT=27018
ENV STVPORT=27020

RUN useradd --home-dir $HOME --create-home --shell /bin/bash $USER
USER $USER
WORKDIR $HOME

RUN steamcmd +login anonymous +force_install_dir $SERVER_DIR +app_update $APP_ID +quit
RUN mkdir $HOME/.steam/sdk32 && ln -s $HOME/.steam/steamcmd/linux32/steamclient.so $HOME/.steam/sdk32/
RUN printf "@ShutdownOnFailedCommand 1\n\
@NoPromptForPassword 1\n\
login anonymous\n\
force_install_dir ${SERVER_DIR}\n\
app_update ${APP_ID}\n\
quit" >> $HOME/tf2.txt
COPY server.cfg ${SERVER_DIR}/tf/cfg

WORKDIR $SERVER_DIR/tf/maps
COPY maps_to_keep .
RUN ls | grep -v "$(cat maps_to_keep)" | xargs rm -rf

WORKDIR $SERVER_DIR
RUN printf "#!/bin/bash\n \
  \$SERVER_DIR/srcds_run \
  -game tf \
  -secured \
  -steam_dir \$HOME/.steam/steamcmd \
  -steamcmd_script \$HOME/tf2.txt \
  -autoupdate \
  -ip \$IP \
  -port \$PORT \
  +clientport \$CLIENTPORT \
  -steamport \$STEAMPORT \
  +tv_port \$STVPORT \
  -strictportbind \
  \$@" > ./entrypoint.sh && chmod +x ./entrypoint.sh

ENTRYPOINT ["./entrypoint.sh"]
CMD ["+sv_pure", "1", "+map", "cp_badlands", "+maxplayers", "24"]

EXPOSE $PORT/tcp
EXPOSE $PORT/udp
EXPOSE $STVPORT/udp

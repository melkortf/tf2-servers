FROM debian:latest AS rcon-build
WORKDIR /build

RUN apt-get -y update\
  && apt-get install -y build-essential git cmake check pkg-config libglib2.0-dev libbsd-dev \
  && rm -rf /var/lib/apt/lists/* \
  && git clone https://github.com/n0la/rcon.git \
  && mkdir rcon/build \
  && cd rcon/build \
  && cmake .. \
  && make


FROM steamcmd/steamcmd:latest
LABEL maintainer="garrappachc@gmail.com"

RUN DEBIAN_FRONTEND=noninteractive \
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
    wget \
    unzip \
    gettext-base \
    libbsd0 \
  && rm -rf /var/lib/apt/lists/*

ARG USER=tf2
ARG HOME=/home/$USER
ARG SERVER_DIR=$HOME/server
ARG APP_ID=232250

ENV USER=$USER
ENV HOME=$HOME
ENV SERVER_DIR=$SERVER_DIR
ENV APP_ID=$APP_ID

RUN useradd --home-dir $HOME --create-home --shell /bin/bash $USER
USER $USER
WORKDIR $HOME

COPY maps_to_keep .
RUN steamcmd +login anonymous +force_install_dir $SERVER_DIR +app_update $APP_ID +quit \
  && find $SERVER_DIR/tf/maps -type f | grep -v "$(cat maps_to_keep)" | xargs rm -rf \
  && rm maps_to_keep

RUN mkdir $HOME/.steam/sdk32 \
  && ln -s $HOME/.steam/steamcmd/linux32/steamclient.so $HOME/.steam/sdk32/ \
  && printf "@ShutdownOnFailedCommand 1\n\
@NoPromptForPassword 1\n\
login anonymous\n\
force_install_dir ${SERVER_DIR}\n\
app_update ${APP_ID}\n\
quit" >> $HOME/tf2.txt

COPY server.cfg.template ${SERVER_DIR}/tf/cfg/server.cfg.template
COPY --from=rcon-build /build/rcon/build/rcon ${SERVER_DIR}/rcon

ENV IP=0.0.0.0
ENV PORT=27015
ENV CLIENT_PORT=27016
ENV STEAM_PORT=27018
ENV STV_PORT=27020

ENV RCON_PASSWORD="123456"
ENV SERVER_HOSTNAME="A Team Fortress 2 server"
ENV SERVER_PASSWORD=
ENV STV_NAME="Source TV"
ENV STV_TITLE="A Team Fortress 2 server Source TV"
ENV STV_PASSWORD=
ENV DOWNLOAD_URL="https://dl.serveme.tf/"

WORKDIR $SERVER_DIR
COPY entrypoint.sh .

ENTRYPOINT ["./entrypoint.sh"]
CMD ["+sv_pure", "1", "+map", "cp_badlands", "+maxplayers", "24"]

EXPOSE $PORT/tcp
EXPOSE $PORT/udp
EXPOSE $STV_PORT/udp

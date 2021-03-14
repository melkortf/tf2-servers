FROM melkortf/tf2-base:latest
LABEL maintainer="garrappachc@gmail.com"

USER root

RUN env DEBIAN_FRONTEND=noninteractive \
  && apt-get -y update \
  && apt-get install -y --no-install-recommends --no-install-suggests wget \
  && rm -rf /var/lib/apt/lists/*

USER $USER
WORKDIR $HOME

ARG METAMOD_TARBALL_FILE_NAME=mmsource-1.11.0-git1144-linux.tar.gz
ARG METAMOD_TARBALL_URL=https://mms.alliedmods.net/mmsdrop/1.11/${METAMOD_TARBALL_FILE_NAME}

ARG SOURCEMOD_TARBALL_FILE_NAME=sourcemod-1.10.0-git6502-linux.tar.gz
ARG SOURCEMOD_TARBALL_URL=https://sm.alliedmods.net/smdrop/1.10/${SOURCEMOD_TARBALL_FILE_NAME}

RUN wget -nv "${METAMOD_TARBALL_URL}" \
  && tar xf "${METAMOD_TARBALL_FILE_NAME}" -C "${SERVER_DIR}/tf" \
  && rm -f "${METAMOD_TARBALL_FILE_NAME}" \
  && wget -nv "${SOURCEMOD_TARBALL_URL}" \
  && tar xf "${SOURCEMOD_TARBALL_FILE_NAME}" -C "${SERVER_DIR}/tf" \
  && rm -f "${SOURCEMOD_TARBALL_FILE_NAME}"

WORKDIR $SERVER_DIR

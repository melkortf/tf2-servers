ARG REGISTRY=ghcr.io
ARG TF2_BASE_TAG=latest
ARG ARCH=i386

FROM ubuntu:22.04 AS plugins
WORKDIR /download
ARG INSTALL_DIR=/server/tf
RUN mkdir -p "${INSTALL_DIR}"

ARG METAMOD_VERSION=1.12.0-git1219
ARG METAMOD_FILE_NAME=mmsource-${METAMOD_VERSION}-linux.tar.gz
ARG METAMOD_URL=https://mms.alliedmods.net/mmsdrop/1.12/${METAMOD_FILE_NAME}
ARG METAMOD_CHECKSUM=f16e67d8de30a46edb2aee8909a885f9f025993284596bb0cfc83b5b32eae05f
ADD --checksum=sha256:${METAMOD_CHECKSUM} ${METAMOD_URL} .
RUN tar xf "${METAMOD_FILE_NAME}" -C "${INSTALL_DIR}/"

ARG SOURCEMOD_VERSION=1.12.0-git7210
ARG SOURCEMOD_FILE_NAME=sourcemod-${SOURCEMOD_VERSION}-linux.tar.gz
ARG SOURCEMOD_URL=https://sm.alliedmods.net/smdrop/1.12/${SOURCEMOD_FILE_NAME}
ARG SOURCEMOD_CHECKSUM=86caf2da0b1e9503c01296b175ace4662106880b57123abf88961feeb2fa9278
ADD --checksum=sha256:${SOURCEMOD_CHECKSUM} ${SOURCEMOD_URL} .
RUN tar xf "${SOURCEMOD_FILE_NAME}" -C "${INSTALL_DIR}/"

FROM ${REGISTRY}/melkortf/tf2-base/${ARCH}:${TF2_BASE_TAG}
LABEL maintainer="garrappachc@gmail.com"

ARG INSTALL_DIR=/server/tf
COPY --from=plugins --chown=tf2 "${INSTALL_DIR}/" "${SERVER_DIR}/tf/"

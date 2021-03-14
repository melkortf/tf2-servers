FROM melkortf/tf2-base:latest
LABEL maintainer="garrappachc@gmail.com"

WORKDIR $SERVER_DIR/tf/maps
COPY maps_to_keep .
RUN ls | grep -v maps_to_keep | xargs rm -rf

WORKDIR $SERVER_DIR

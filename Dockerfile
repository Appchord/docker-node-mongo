FROM alpine:edge

ENV NPM_CONFIG_LOGLEVEL info
ENV NODE_VERSION 7.4.0

RUN adduser -D -u 1000 node \
    && apk add --no-cache \
    bash git python make \
        libstdc++ \
    && apk add --no-cache --virtual .build-deps \
        binutils-gold \
        curl \
        g++ \
        gcc \
        gnupg \
        libgcc \
        linux-headers \
        make \
        python \
    && curl -SLO "https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION.tar.xz" \
    && curl -SLO "https://nodejs.org/dist/v$NODE_VERSION/SHASUMS256.txt.asc" \
    && tar -xf "node-v$NODE_VERSION.tar.xz" \
    && cd "node-v$NODE_VERSION" \
    && ./configure \
    && make -j$(getconf _NPROCESSORS_ONLN) \
    && make install \
    && apk del .build-deps \
    && cd .. \
    && rm -Rf "node-v$NODE_VERSION" \
    && rm "node-v$NODE_VERSION.tar.xz" SHASUMS256.txt.asc \
    && echo http://dl-4.alpinelinux.org/alpine/edge/testing >> /etc/apk/repositories \
    && apk add --no-cache mongodb \
    && rm /usr/bin/mongosniff /usr/bin/mongoperf \
    && apk add --no-cache g++ \
    && mkdir -p /data/db \
    && chown -R mongodb:mongodb /data/db \
    && chown -R mongodb /data/db

RUN npm install -g yarn
RUN yarn global add node-gyp gulp

ENTRYPOINT [ "node" ]


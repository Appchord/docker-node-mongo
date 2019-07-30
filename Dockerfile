FROM node:12.7.0-alpine

# --without-npm

RUN echo http://dl-4.alpinelinux.org/alpine/v3.9/community >> /etc/apk/repositories \
    && apk add --no-cache mongodb git\
    && rm -f /usr/bin/mongoperf \
    && apk add --no-cache g++ \
    && mkdir -p /data/db \
    && chown -R mongodb:mongodb /data/db \
    && chown -R mongodb /data/db \
    && yarn global add node-gyp

#RUN npm install -g yarn
#RUN yarn global add node-gyp gulp

ENTRYPOINT [ "node" ]
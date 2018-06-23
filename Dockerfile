FROM node:10.5.0-alpine

# --without-npm

RUN echo http://dl-4.alpinelinux.org/alpine/edge/testing >> /etc/apk/repositories \
    && apk add --no-cache mongodb \
    && rm /usr/bin/mongoperf \
    && apk add --no-cache g++ \
    && mkdir -p /data/db \
    && chown -R mongodb:mongodb /data/db \
    && chown -R mongodb /data/db \
    && yarn global add node-gyp gulp

#RUN npm install -g yarn
#RUN yarn global add node-gyp gulp

ENTRYPOINT [ "node" ]
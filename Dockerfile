FROM nodered/node-red

USER root

WORKDIR /
COPY ./data ./data

WORKDIR /data
RUN npm install

WORKDIR /usr/src/node-red
RUN npm install
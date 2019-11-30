FROM node:10.15.3-alpine

WORKDIR /app
COPY package.json /app
RUN npm install
COPY . /app

ENV kafkaHost=10.25.240.28:9092

CMD node app.js
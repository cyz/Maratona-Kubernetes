FROM node:8-alpine

ADD . /src

WORKDIR /src 

RUN npm i -g typescript pm2 --production --silent

RUN npm i --production --silent

RUN npm run build

CMD npm start
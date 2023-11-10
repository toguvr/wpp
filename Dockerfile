FROM node:lts-alpine3.18 as builder


RUN apk add wget && \
  apk add --no-cache git

WORKDIR /home/node/app

COPY package*.json ./

RUN yarn install
COPY . .

FROM node:lts-alpine3.18
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true
WORKDIR /home/node/app
RUN apk add chromium
COPY --from=builder /home/node/app/ .
EXPOSE 3000
CMD ["npm", "run", "start"]



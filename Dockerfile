FROM node:10.15 AS build

WORKDIR /root/

RUN mkdir -p static/css/ && mkdir -p static/js/

COPY package.json package-lock.json ./

RUN npm ci

COPY assets/ ./assets/

RUN npm run build


FROM yanqd0/hugo

COPY --from=build /root/static/ ./static/

COPY . .

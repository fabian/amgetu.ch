FROM node:10.15 AS npm

WORKDIR /root/

RUN mkdir -p static/css/ && mkdir -p static/js/

COPY package.json package-lock.json ./

RUN npm ci

COPY assets/ ./assets/

RUN npm run build


FROM yanqd0/hugo

COPY --from=npm /root/static/ ./static/

COPY . .

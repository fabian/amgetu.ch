FROM node:10.15 AS build

WORKDIR /root/

RUN mkdir -p static/css/ && mkdir -p static/js/

COPY package.json package-lock.json ./

RUN npm ci

COPY assets/ ./assets/

RUN npm run build


FROM buildpack-deps:jessie

EXPOSE 1313

WORKDIR /root/

ADD https://github.com/gohugoio/hugo/releases/download/v0.54.0/hugo_0.54.0_Linux-64bit.deb /tmp/hugo.deb
RUN dpkg -i /tmp/hugo.deb && rm /tmp/hugo.deb

COPY --from=build /root/static/ ./static/

COPY . .

CMD hugo server --bind=0.0.0.0

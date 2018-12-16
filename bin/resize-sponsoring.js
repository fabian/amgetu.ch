#!/usr/bin/env node

const fs = require('fs');
const sharp = require('sharp');

const src = 'sponsoring/';
const dest = 'static/img/sponsoring/';

fs.readdir(src, function(err, files) {

  files = files.filter(file => !(/(^|\/)\.[^\/\.]/g).test(file));

  console.log(files);

  for (let file of files) {

    sharp(src + file)
      .resize(400, 200, {fit: 'contain', background: {r: 255, g: 255, b: 255}})
      .toFile(dest + file);

  }

});

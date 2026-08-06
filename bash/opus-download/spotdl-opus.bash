#!/bin/bash

spotify-dlp \
  download \
  "$1" \
  --format opus \
  --yt-dlp-args \
  "--remote-components ejs:github --js-runtimes node --extractor-args youtube:player_client=android"

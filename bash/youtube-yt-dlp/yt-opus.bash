#!/bin/bash

# Option 1
# conda activate work
# yt-dlp --extract-audio --audio-format opus $1

# Option 2
# conda activate work
yt-dlp \
  --remote-components ejs:github \
  --js-runtimes node \
  --extractor-args "youtube:player_client=android" \
  --extract-audio --audio-format opus \
  "$1"
# --cookies-from-browser firefox \

# Option 3
# conda activate work
# # Exactly
# yt-dlp \
#   --remote-components ejs:github \
#   --js-runtimes node:/home/johnny/.nvm/versions/node/v24.16.0/bin/node \
#   --cookies-from-browser firefox \
#   -f "bestvideo+bestaudio" \
#   -v \
#   "https://www.youtube.com/watch?v=ZOOCtEpGZG0"

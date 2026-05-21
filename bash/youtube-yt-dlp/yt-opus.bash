#!/bin/bash

conda activate work
yt-dlp --extract-audio --audio-format opus $1

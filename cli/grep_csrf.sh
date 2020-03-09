#!/bin/bash

# https://unix.stackexchange.com/questions/226493/excluding-nested-directories-with-grep

clear; egrep \
  --line-number --recursive --color=always \
  --ignore-case \
  --context=2 \
  --include \*.js --include \*.pug \
  --exclude \*.min.js \
  --exclude-dir=node_modules \
  --exclude-dir=ace \
  "csrf"

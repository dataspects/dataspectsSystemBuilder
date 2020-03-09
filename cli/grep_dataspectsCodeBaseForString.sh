#!/bin/bash

clear; egrep \
--line-number --recursive --color=always \
--ignore-case \
--context=0 \
  --include \*.js \
  --include \*.pug \
  --include \*.json \
  --include \*.go \
--exclude \*.min.js \
--exclude-dir=node_modules \
--exclude-dir=ace \
  "$1" \
   2>&-
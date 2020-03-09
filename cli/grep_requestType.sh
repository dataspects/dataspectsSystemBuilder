#!/bin/bash

clear; egrep \
--line-number --recursive --color=always \
--ignore-case \
--context=1 \
--include \*.js --include \*.pug \
--exclude \*.min.js \
--exclude-dir=node_modules \
--exclude-dir=ace \
  "requestType"

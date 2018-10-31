#!/bin/bash

sudo docker container stop `sudo docker ps --no-trunc -aq`
sudo docker rm `sudo docker ps --no-trunc -aq`

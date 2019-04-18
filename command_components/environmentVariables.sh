#!/bin/bash
if [[ ! $CONTROL_FOLDER_PATH ]]; then CONTROL_FOLDER_PATH=`pwd`/../dss; fi
DOMAIN_NAME="$(basename -- $CONTROL_FOLDER_PATH)"
if [[ ! $UI_SESSION_SECRET ]]; then UI_SESSION_SECRET=dummy; fi
if [[ ! $TIKA_USERNAME ]]; then TIKA_USERNAME=dummy; fi
if [[ ! $TIKA_PASSWORD ]]; then TIKA_PASSWORD=dummy; fi
if [[ ! $UI_FEED_SERVICE_API_KEY ]]; then UI_FEED_SERVICE_API_KEY=aslkdjasldkjlaskdj; fi
if [[ ! $DOCKER_VOLUMES_MODE ]]; then DOCKER_VOLUMES_MODE=automatic; fi
if [[ ! $DOCKER_COMPOSE_FILE ]]; then DOCKER_COMPOSE_FILE=docker-compose-standard; fi
if [[ ! $PLATFORM ]]; then PLATFORM="linux"; fi
if [ $PLATFORM == "linux" ]; then PRIVILEGE_ESCALATION="--ask-become-pass --become-method sudo"; else PRIVILEGE_ESCALATION=""; fi

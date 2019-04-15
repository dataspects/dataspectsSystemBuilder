#!/bin/bash
#[[IsDataspectsSystemBuildConfiguration::Minimal UI Development]]
CONTROL_FOLDER_PATH=/home/lex/dssminimaluidevelopment # Must be absolute!
PLATFORM=linux # linux|mac|windows
DOCKER_VOLUMES_MODE=automatic # automatic|manual
DOCKER_COMPOSE_FILE=docker-compose-minimal-ui-DEVELOPMENT
source command_components/environmentVariables.sh
ANSIBLETAGS=(
  100_create_dataspectsSystem_control_folder_on_host
  ###
  200_compile_and_copy_docker_compose_file
  210_run_docker_compose
  ###
  500_configure_nodejs
  ###
  700_prepare_indexing
)
source command_components/ansiblePlaybookCommand.sh

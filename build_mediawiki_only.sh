#!/bin/bash
#[[IsDataspectsSystemBuildConfiguration::MediaWiki only]]
CONTROL_FOLDER_PATH=/home/vagrant/build_mediawiki_only # Must be absolute!
PLATFORM=linux # linux|mac|windows
DOCKER_VOLUMES_MODE=automatic # automatic|manual
DOCKER_COMPOSE_FILE=docker-compose-mediawiki-only
source command_components/environmentVariables.sh
ANSIBLETAGS=(
  100_create_dataspectsSystem_control_folder_on_host
  200_compile_and_copy_docker_compose_file
  210_run_docker_compose
  ### Comment all following tags for manual installation on Docker stack in accordance with C1470408196
  300_install_mediawiki
  310_configure_proxy
  320_install_mediawiki_extensions
  330_execute_mediawiki_maintenance_runJobs
)
source command_components/ansiblePlaybookCommand.sh

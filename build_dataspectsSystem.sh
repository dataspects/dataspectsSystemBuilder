#!/bin/bash

if [[ ! $CONTROL_FOLDER_PATH ]]; then CONTROL_FOLDER_PATH=/home/lex/cookbookfindandlearnnet; fi
DOMAIN_NAME="$(basename -- $CONTROL_FOLDER_PATH)"
if [[ ! $AWS_ACCESS_KEY_ID ]]; then AWS_ACCESS_KEY_ID=dummy; fi
if [[ ! $AWS_SECRET_ACCESS_KEY ]]; then AWS_SECRET_ACCESS_KEY=dummy; fi
if [[ ! $UI_SESSION_SECRET ]]; then UI_SESSION_SECRET=dummy; fi

ANSIBLETAGS=(
  create_dataspectsSystem_control_folder_on_host
  compile_and_copy_docker_compose_file
  run_docker_compose
  # Comment the following for manual installation on Docker stack in accordance
  # with C1470408196
  install_mediawiki
  configure_proxy
  install_mediawiki_extensions
  execute_mediawiki_maintenance_runJobs
  install_backup_functionality
  install_clone_functionality
  provision_and_index_and_compare
  backup_and_clone
)

time ansible-playbook \
  --extra-vars @build_dataspectsSystem_ANSIBLE_VARS.yml \
  --extra-vars dataspectsSystem_control_folder_on_host=$CONTROL_FOLDER_PATH \
  --extra-vars mediawikiDomainNameInHostFile=$DOMAIN_NAME \
  --extra-vars aws_access_key_id=$AWS_ACCESS_KEY_ID \
  --extra-vars aws_secret_access_key=$AWS_SECRET_ACCESS_KEY \
  --extra-vars ui_session_secret=$UI_SESSION_SECRET \
  --tags $(IFS=, eval 'echo "${ANSIBLETAGS[*]}"') \
  --ask-become-pass \
  --become-method sudo \
      ansible_playbooks/create_dataspectsSystem_control_folder_on_host.yml \
      ansible_playbooks/compile_and_copy_docker_compose_file.yml \
      ansible_playbooks/run_docker_compose.yml \
      ansible_playbooks/install_mediawiki.yml \
      ansible_playbooks/install_mediawiki_extensions.yml \
      ansible_playbooks/execute_mediawiki_maintenance_runJobs.yml \
      ansible_playbooks/install_backup_and_clone_functionality.yml \
      ansible_playbooks/provision_as_cookbookfalnet.yml \
      ansible_playbooks/backup_and_clone.yml

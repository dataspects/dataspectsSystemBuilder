#!/bin/bash

ANSIBLETAGS=(
  create_dataspectsSystem_control_folder_on_host
  compile_and_copy_docker_compose_file
  run_docker_compose
  # install_mediawiki
  install_bluespice_pro
  # install_mediawiki_extensions
  # install_mediawiki_extension_VISUALEDITOR
  # install_mediawiki_extension_SEMANTICMEDIAWIKI
  # install_mediawiki_extension_SEMANTICRESULTFORMATS
  execute_mediawiki_maintenance_runJobs
)

time ansible-playbook \
  --extra-vars @build_dataspectsSystem_ANSIBLE_VARS.yml \
  --tags $(IFS=, eval 'echo "${ANSIBLETAGS[*]}"') \
  --ask-become-pass \
  --become-method sudo \
      ansible_playbooks/create_dataspectsSystem_control_folder_on_host.yml \
      ansible_playbooks/compile_and_copy_docker_compose_file.yml \
      ansible_playbooks/run_docker_compose.yml \
      ansible_playbooks/install_mediawiki.yml \
      ansible_playbooks/install_bluespice_pro.yml \
      ansible_playbooks/install_mediawiki_extensions.yml \
      ansible_playbooks/execute_mediawiki_maintenance_runJobs.yml

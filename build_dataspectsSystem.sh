#!/bin/bash

ANSIBLETAGS=(
  create_dataspectsSystem_path_on_host
  copy_docker_compose_file
  run_docker_compose
  install_mediawiki
  install_mediawiki_extensions
  install_mediawiki_extension_VISUALEDITOR
  install_mediawiki_extension_SEMANTICMEDIAWIKI
  install_mediawiki_extension_SEMANTICRESULTFORMATS
  # place_run_containers_manually_scripts
  # place_system_profiles
  # inject_dataspectsSystemCoreOntology
  # extract_dataspectsSystemCoreOntology
  # execute_mediawiki_maintenance_runJobs
  # reset_elasticsearch_index
  # place_dataspects_search_config_files
)

time ansible-playbook \
  --extra-vars @build_dataspectsSystem_ANSIBLE_VARS.yml \
  --tags $(IFS=, eval 'echo "${ANSIBLETAGS[*]}"') \
  --become-method sudo \
  --ask-become-pass \
      ansible_playbooks/create_dataspectsSystem_path_on_host.yml \
      ansible_playbooks/compile_docker_compose_file.yml \
      ansible_playbooks/run_docker_compose.yml \
      ansible_playbooks/place_run_containers_manually_scripts.yml \
      ansible_playbooks/install_mediawiki.yml \
      ansible_playbooks/install_mediawiki_extensions.yml \
      ansible_playbooks/place_system_profiles.yml \
      ansible_playbooks/inject_dataspectsSystemCoreOntology_into_mediawiki.yml \
      ansible_playbooks/extract_dataspectsSystemCoreOntology_from_mediawiki.yml \
      ansible_playbooks/execute_mediawiki_maintenance_runJobs.yml \
      ansible_playbooks/reset_elasticsearch_index.yml \
      ansible_playbooks/place_dataspects_search_config_files.yml \
    # ansible_playbooks/index_dataspectsStandardSystem.yml \
    # ansible_playbooks/index_dataspectsSystemSoftware.yml

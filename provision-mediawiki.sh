#!/bin/bash

export COMPOSER_VERSION=1.10.19

export SYSTEM_ROOT=/home/dserver/system_root
export MEDIAWIKI_VERSION=1.36.2
export SEMANTIC_MEDIAWIKI_VERSION=3.2.3
export SEMANTIC_RESULTS_FORMATS_VERSION=~3.1
export MEDIAWIKI_GITHUB_VERSION=~1.4
export MEDIAWIKI_MERMAID_VERSION=~2.1

export MEDIAWIKI_NAME=dataspectsMediaWiki

export APACHE_CONTAINER_NAME=mediawiki_canasta

ANSIBLETAGS=(
  300_clone_mediawiki
  301_install_composer
  302_run_composer
  303_install_mediawiki
  304_adjust_localsettings
  305_place_INITIAL_INSTRUCTIONS
  320_install_mediawiki_extensions
  330_execute_mediawiki_maintenance_runJobs
  340_install_maintenance_functionality
)

################################################################################

export MEDIAWIKI_ADMIN_PASSWORD=123adminpass456

time ansible-playbook \
  --inventory ./inventory \
  --extra-vars mediawikiDockerServiceName=$APACHE_CONTAINER_NAME \
  --extra-vars composer_version=$COMPOSER_VERSION \
  --extra-vars mediawiki_version=$MEDIAWIKI_VERSION \
  --extra-vars mediawiki_name=$MEDIAWIKI_NAME \
  --extra-vars system_root=$SYSTEM_ROOT \
  --extra-vars semantic_mediawiki_version=$SEMANTIC_MEDIAWIKI_VERSION \
  --extra-vars semantic_result_formats_version=$SEMANTIC_RESULTS_FORMATS_VERSION \
  --extra-vars mediawiki_github_version=$MEDIAWIKI_GITHUB_VERSION \
  --extra-vars mediawiki_mermaid_version=$MEDIAWIKI_MERMAID_VERSION \
  --extra-vars mediawiki_admin_user_password=$MEDIAWIKI_ADMIN_PASSWORD \
  --extra-vars mediawikiDomainNameInHostFile=dserver \
  --tags $(IFS=, eval 'echo "${ANSIBLETAGS[*]}"') \
  --become-method sudo \
      ./ansible_playbooks/300_MediaWiki/300_install_mediawiki.yml \
      ./ansible_playbooks/300_MediaWiki/320_install_mediawiki_extensions.yml \
      ./ansible_playbooks/300_MediaWiki/330_execute_mediawiki_maintenance_runJobs.yml \
      ./ansible_playbooks/300_MediaWiki/340_install_maintenance_functionality.yml
#!/bin/bash

export MEDIAWIKI_VERSION=REL1_33
export SEMANTIC_MEDIAWIKI_VERSION=~3.1
export SEMANTIC_RESULTS_FORMATS_VERSION=~3.1
export MEDIAWIKI_GITHUB_VERSION=~1.4
export MEDIAWIKI_MERMAID_VERSION=~2.1

export MEDIAWIKI_NAME=dataspects MediaWiki

ANSIBLETAGS=(
#   300_install_mediawiki
  301_install_composer
  302_run_composer
  # 310_configure_proxy
#   320_install_mediawiki_extensions
#   330_execute_mediawiki_maintenance_runJobs
)

################################################################################

export MEDIAWIKI_ADMIN_PASSWORD=123adminpass456

time ansible-playbook \
  --inventory ./inventory \
  --extra-vars mediawikiDockerServiceName=mediawiki \
  --extra-vars mediawiki_version=$MEDIAWIKI_VERSION \
  --extra-vars mediawiki_name=$MEDIAWIKI_NAME \
  --extra-vars semantic_mediawiki_version=$SEMANTIC_MEDIAWIKI_VERSION \
  --extra-vars semantic_result_formats_version=$SEMANTIC_RESULTS_FORMATS_VERSION \
  --extra-vars mediawiki_github_version=$MEDIAWIKI_GITHUB_VERSION \
  --extra-vars mediawiki_mermaid_version=$MEDIAWIKI_MERMAID_VERSION \
  --extra-vars mediawiki_admin_user_password=$MEDIAWIKI_ADMIN_PASSWORD \
  --extra-vars mediawikiDomainNameInHostFile=$DOMAIN_NAME \
  --tags $(IFS=, eval 'echo "${ANSIBLETAGS[*]}"') \
  --become-method sudo \
      ./ansible_playbooks/300_MediaWiki/300_install_mediawiki.yml \
    #   ./ansible_playbooks/300_MediaWiki/310_configure_proxy.yml \
    #   ./ansible_playbooks/300_MediaWiki/320_install_mediawiki_extensions.yml \
    #   ./ansible_playbooks/300_MediaWiki/330_execute_mediawiki_maintenance_runJobs.yml \
    #   ./ansible_playbooks/800_Backup_and_Clone/800_install_backup_and_clone_functionality.yml \
    #   ./ansible_playbooks/800_Backup_and_Clone/810_backup_and_clone.yml \
    #   ./ansible_playbooks/900_Tools/900_compare.yml

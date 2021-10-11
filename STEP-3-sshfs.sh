#!/bin/bash

VMNAME=MediaWiki211011

user@host:~/dataspectsSystemBuilder$ sshfs -o allow_other -p 2222 \
    dserver@localhost:/home/dserver /home/lex/$VMNAME
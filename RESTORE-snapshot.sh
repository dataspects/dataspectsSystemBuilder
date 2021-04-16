#!/bin/bash

VMNAME=MWM210409
VBoxManage controlvm $VMNAME poweroff
VBoxManage snapshot $VMNAME restore FRESH
VBoxManage startvm $VMNAME --type headless
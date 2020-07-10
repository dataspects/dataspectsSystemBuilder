#!/bin/sh

MW_INSTALL_PATH=/var/www/html/w
RUNJOBS=$MW_INSTALL_PATH/maintenance/runJobs.php
echo Starting job service...
# Wait a minute after the server starts up to give other processes time to get started
sleep 60
echo Started.
while true; do
	# Job types that need to be run ASAP mo matter how many of them are in the queue
	# Those jobs should be very "cheap" to run
	php $RUNJOBS --type="enotifNotify"
	# Everything else, limit the number of jobs on each batch
	# The --wait parameter will pause the execution here until new jobs are added,
	# to avoid running the loop without anything to do
	php $RUNJOBS --wait --maxjobs=20
	# Wait some seconds to let the CPU do other things, like handling web requests, etc
	echo Waiting for 10 seconds...
	sleep 10
done
#!/bin/sh -e

~/src/jenkins-tools/bin/delete-job.sh gnu-privacy-guard-tools || true
~/src/jenkins-tools/bin/put-job.sh gnu-privacy-guard-tools job.xml

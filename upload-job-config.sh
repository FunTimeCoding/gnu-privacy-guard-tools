#!/bin/sh -e

~/src/jenkins-tools/bin/delete-job.sh gpg-tools || true
~/src/jenkins-tools/bin/put-job.sh gpg-tools job.xml

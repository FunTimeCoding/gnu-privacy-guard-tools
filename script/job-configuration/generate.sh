#!/bin/sh -e

# shellcheck disable=SC2016
jjm --locator ssh://git@vc.shiin.org:2222/devops/gnu-privacy-guard-tools.git --build-command script/build.sh --checkstyle 'build/log/checkstyle-*.xml' --recipients funtimecoding@gmail.com > job.xml

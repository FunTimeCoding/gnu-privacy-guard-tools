#!/bin/sh -e

# shellcheck disable=SC2016
jjm --locator git@github.com:FunTimeCoding/gnu-privacy-guard-tools.git --build-command script/build.sh --checkstyle 'build/log/checkstyle-*.xml' --recipients funtimecoding@gmail.com > job.xml

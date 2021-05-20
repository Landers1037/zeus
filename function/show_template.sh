#!/usr/bin/env bash
template=${ZEUS_ROOT}/register/cmds
if [[ -f ${template} ]];then
  echo "$(cat ${template})"
else
  echo "warn: template not exist."
fi
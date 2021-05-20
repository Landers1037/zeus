#!/usr/bin/env bash
service_dir=$ZEUS_ROOT/service
apps=$(ls ${service_dir})
for app in ${apps}
do
  if [[ -d ${service_dir}/${app} ]];then
    echo "(*) ${app}"
  fi
done
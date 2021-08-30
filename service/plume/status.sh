#!/bin/bash
# cmds for zeus apps

app_dir=${ZEUS_APP_ROOT}/plume
app_name=plume
status=$(ps ax|grep ${app_name}|grep -v "status.sh"|grep -v grep)
if [[ -n ${status} ]];then
  exit 0
else
  exit 1
fi
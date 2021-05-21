#!/bin/bash
# cmds for zeus apps

app_dir=${ZEUS_APP_ROOT}/frp
app_name=frps
status=$(ps ax|grep ${app_name}|grep -v grep)
if [[ -n ${status} ]];then
  exit 0
else
  exit 1
fi
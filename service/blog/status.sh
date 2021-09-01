#!/bin/bash
# cmds for zeus apps
app_dir=${ZEUS_APP_ROOT}/blog
app_name=app_blog
status=$(ps ax|grep ${app_name}|grep -v zeus|grep -v grep)
if [[ -n ${status} ]];then
  exit 0
else
  exit 1
fi
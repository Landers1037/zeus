#!/bin/bash
# cmds for zeus apps

app_name=redis-server
status=$(ps ax|grep ${app_name}|grep -v grep)
if [[ -n ${status} ]];then
  exit 0
else
  exit 1
fi
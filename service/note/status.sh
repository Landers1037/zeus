#!/bin/bash
# cmds for zeus apps
conf=note.conf
app_dir=${ZEUS_APP_ROOT}/note
app_name=nginx

status=$(ps ax|grep ${app_name}|grep -v zeus|grep -v grep)
if [[ -n ${status} && -f ${ZEUS_NGINX_CONF}/${conf} && ! -f ${ZEUS_NGINX_CONF}/${conf}.stop ]];then
  exit 0
else
  exit 1
fi
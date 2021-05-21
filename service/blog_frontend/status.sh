#!/bin/bash
# cmds for zeus apps

# 对于前端服务当前仅判断nginx + conf.stop
conf=blog_frontend.conf
conf2=blog.conf
app_dir=${ZEUS_APP_ROOT}/blog_frontend
app_name=nginx

status=$(ps ax|grep ${app_name}|grep -v grep)
if [[ -n ${status} && -f ${ZEUS_NGINX_CONF}/${conf} && ! -f ${ZEUS_NGINX_CONF}/${conf}.stop ]];then
  exit 0
else
  exit 1
fi
#!/usr/bin/env bash

for i in {1..100}
do
  pid=$(ps ax|grep frps|grep -v grep|sed -n '1P'|awk '{print $1}')
  if [[ -z $pid ]];then
    break
  else
    kill -9 $pid
  fi
done

conf=home.conf
if [[ ! -f ${ZEUS_NGINX_CONF}/${conf} ]];then
  echo "服务配置文件不存在"
  exit 0
else
  mv ${ZEUS_NGINX_CONF}/${conf} ${ZEUS_NGINX_CONF}/${conf}.stop
  nginx -s reload
  exit 0
fi
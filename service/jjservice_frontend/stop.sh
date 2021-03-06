#!/usr/bin/env bash
# try find nginx conf

conf=jjservice_frontend.conf
conf2=jjservice.conf
if [[ ! -f ${ZEUS_NGINX_CONF}/${conf} ]];then
  echo "服务配置文件不存在"
  exit 1
else
  mv ${ZEUS_NGINX_CONF}/${conf} ${ZEUS_NGINX_CONF}/${conf}.stop
  mv ${ZEUS_NGINX_CONF}/${conf2} ${ZEUS_NGINX_CONF}/${conf2}.stop
  nginx -s reload
  exit 0
fi
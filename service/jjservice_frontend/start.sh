#!/usr/bin/env bash
# jjservice frontend

# try find nginx conf
if [[ ! -f ${ZEUS_NGINX_CONF}/jjservice_frontend.conf.stop ]];then
  echo "服务配置文件不存在"
  exit 1
else
  mv ${ZEUS_NGINX_CONF}/jjservice_frontend.conf.stop ${ZEUS_NGINX_CONF}/jjservice_frontend.conf
  mv ${ZEUS_NGINX_CONF}/jjservice.conf.stop ${ZEUS_NGINX_CONF}/jjservice.conf
  nginx -s reload
  exit 0
fi
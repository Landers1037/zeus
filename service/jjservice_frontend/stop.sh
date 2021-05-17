#!/usr/bin/env bash
# try find nginx conf
if [[ ! -f ${ZEUS_NGINX_CONF}/jjservice_frontend.conf ]];then
  echo "服务配置文件不存在"
  exit 1
else
  mv ${ZEUS_NGINX_CONF}/jjservice_frontend.conf ${ZEUS_NGINX_CONF}/jjservice_frontend.conf.stop
  mv ${ZEUS_NGINX_CONF}/jjservice.conf ${ZEUS_NGINX_CONF}/jjservice.conf.stop
  nginx -s reload
  exit 0
fi
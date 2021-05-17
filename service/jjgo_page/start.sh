#!/usr/bin/env bash
# jjgo_page is nginx frontend

# try find nginx conf
if [[ ! -f ${ZEUS_NGINX_CONF}/jjgo_page.conf.stop ]];then
  echo "服务配置文件不存在"
  exit 1
else
  mv ${ZEUS_NGINX_CONF}/jjgo_page.conf.stop ${ZEUS_NGINX_CONF}/jjgo_page.conf
  nginx -s reload
  exit 0
fi
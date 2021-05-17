#!/usr/bin/env bash
# try find nginx conf
if [[ ! -f ${ZEUS_NGINX_CONF}/jjgo_page.conf ]];then
  echo "服务配置文件不存在"
  exit 1
else
  mv ${ZEUS_NGINX_CONF}/jjgo_page.conf ${ZEUS_NGINX_CONF}/jjgo_page.conf.stop
  nginx -s reload
  exit 0
fi
#!/usr/bin/env bash
# mgekdoc is frontend app

# try find nginx conf
if [[ ! -f ${ZEUS_NGINX_CONF}/mgekdoc.conf.stop ]];then
  echo "服务配置文件不存在"
  exit 1
else
  mv ${ZEUS_NGINX_CONF}/mgekdoc.conf.stop ${ZEUS_NGINX_CONF}/mgekdoc.conf
  nginx -s reload
  exit 0
fi
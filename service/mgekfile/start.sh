#!/usr/bin/env bash
# mgekfile is nginx based

# try find nginx conf
if [[ ! -f ${ZEUS_NGINX_CONF}/mgekfile.conf.stop ]];then
  echo "服务配置文件不存在"
  exit 1
else
  mv ${ZEUS_NGINX_CONF}/mgekfile.conf.stop ${ZEUS_NGINX_CONF}/mgekfile.conf
  nginx -s reload
  exit 0
fi
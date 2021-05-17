#!/usr/bin/env bash
# try find nginx conf
if [[ ! -f ${ZEUS_NGINX_CONF}/resume.conf ]];then
  echo "服务配置文件不存在"
  exit 1
else
  mv ${ZEUS_NGINX_CONF}/resume.conf ${ZEUS_NGINX_CONF}/resume.conf.stop
  nginx -s reload
  exit 0
fi
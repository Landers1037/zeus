#!/usr/bin/env bash
# jjgo_page is nginx frontend

# try find nginx conf
conf=jjgo_page.conf
if [[ ! -f ${ZEUS_NGINX_CONF}/${conf}.stop && ! -f ${ZEUS_NGINX_CONF}/${conf} ]];then
  echo "服务配置文件不存在"
  exit 1
elif [[ -f ${ZEUS_NGINX_CONF}/${conf} ]]; then
    nginx -s reload
    exit 0
else
  mv ${ZEUS_NGINX_CONF}/${conf}.stop ${ZEUS_NGINX_CONF}/${conf}
  nginx -s reload
  exit 0
fi
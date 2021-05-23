#!/usr/bin/env bash
# jjservice frontend

# try find nginx conf
conf=jjservice_frontend.conf
conf2=jjservice.conf
if [[ ! -f ${ZEUS_NGINX_CONF}/${conf}.stop && ! -f ${ZEUS_NGINX_CONF}/${conf} ]];then
  echo "服务配置文件不存在"
  exit 1
elif [[ -f ${ZEUS_NGINX_CONF}/${conf} && -f ${ZEUS_NGINX_CONF}/${conf2} ]]; then
    nginx -s reload
    exit 0
else
  mv ${ZEUS_NGINX_CONF}/${conf}.stop ${ZEUS_NGINX_CONF}/${conf}
  mv ${ZEUS_NGINX_CONF}/${conf2}.stop ${ZEUS_NGINX_CONF}/${conf2}
  nginx -s reload
  exit 0
fi
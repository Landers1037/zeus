#!/usr/bin/env bash
# blog frontend app

# try find nginx conf
conf=blog_frontend.conf
conf2=blog.conf
if [[ ! -f ${ZEUS_NGINX_CONF}/${conf}.stop && ! -f ${ZEUS_NGINX_CONF}/${conf} ]];then
  echo "服务配置文件不存在"
  exit 1
elif [[ -f ${ZEUS_NGINX_CONF}/${conf} ]]; then
    nginx -s reload
    exit 0
else
  mv ${ZEUS_NGINX_CONF}/${conf}.stop ${ZEUS_NGINX_CONF}/${conf}
  mv ${ZEUS_NGINX_CONF}/${conf2}.stop ${ZEUS_NGINX_CONF}/${conf}
  nginx -s reload
  exit 0
fi
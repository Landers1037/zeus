#!/usr/bin/env bash
# try find nginx conf
if [[ ! -f ${ZEUS_NGINX_CONF}/blog_frontend.conf ]];then
  echo "服务配置文件不存在"
  exit 1
else
  mv ${ZEUS_NGINX_CONF}/blog_frontend.conf ${ZEUS_NGINX_CONF}/blog_frontend.conf.stop
  mv ${ZEUS_NGINX_CONF}/blog.conf ${ZEUS_NGINX_CONF}/blog.conf.stop
  nginx -s reload
  exit 0
fi
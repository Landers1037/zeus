#!/usr/bin/env bash
# blog frontend app

# try find nginx conf
if [[ ! -f ${ZEUS_NGINX_CONF}/blog_frontend.conf.stop ]];then
  echo "服务配置文件不存在"
  exit 1
else
  mv ${ZEUS_NGINX_CONF}/blog_frontend.conf.stop ${ZEUS_NGINX_CONF}/blog_frontend.conf
  mv ${ZEUS_NGINX_CONF}/blog.conf.stop ${ZEUS_NGINX_CONF}/blog.conf
  nginx -s reload
  exit 0
fi
#!/bin/bash
# cmds for zeus apps
conf=cookbook.conf
if [[ ! -f ${ZEUS_NGINX_CONF}/${conf}.stop && ! -f ${ZEUS_NGINX_CONF}/${conf} ]];then
  echo ""
  exit 1
elif [[ -f ${ZEUS_NGINX_CONF}/${conf} ]]; then
  nginx -s reload
else
  mv ${ZEUS_NGINX_CONF}/${conf}.stop ${ZEUS_NGINX_CONF}/${conf}
  nginx -s reload
  exit 0
fi
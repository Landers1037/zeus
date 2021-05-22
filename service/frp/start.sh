#!/usr/bin/env bash
# frp use nginx

cd ${ZEUS_APP_ROOT}/frp || exit 1
nohup ./frps -c ./frps.ini > ${ZEUS_APP_LOG}/frp.log 2>&1 &

# start nginx
conf=frp.conf
if [[ ! -f ${ZEUS_NGINX_CONF}/${conf}.stop && ! -f ${ZEUS_NGINX_CONF}/${conf} ]];then
  echo "服务配置文件不存在"
  exit 0
elif [[ -f ${ZEUS_NGINX_CONF}/${conf} ]]; then
    nginx -s reload
    exit 0
else
  mv ${ZEUS_NGINX_CONF}/${conf}.stop ${ZEUS_NGINX_CONF}/${conf}
  nginx -s reload
  exit 0
fi
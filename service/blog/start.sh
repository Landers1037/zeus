#!/usr/bin/env bash
# blog app

cd ${ZEUS_APP_ROOT}/blog || exit 1
# 使用负载均衡模式启动
for p in {10005..10009}
do
  echo "启动监听$p"
  nohup ./app_blog -p $p > ${ZEUS_APP_LOG}/blog.log 2>&1 &
done
exit 0
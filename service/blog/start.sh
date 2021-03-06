#!/usr/bin/env bash
# blog app

cd ${ZEUS_APP_ROOT}/blog || exit 1
# 使用负载均衡模式启动
for p in {10002..10003}
do
  echo "启动监听$p"
  nohup ./app_blog web cluster -p $p > ${ZEUS_APP_LOG}/blog.log 2>&1 &
done
exit 0
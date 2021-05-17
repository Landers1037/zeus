#!/usr/bin/env bash
# jjgo app

# jjgo 内部会自动处理多端口监听
cd ${ZEUS_APP_ROOT}/jjgo || exit 1
# 使用负载均衡模式启动
nohup ./app_jjgo > ${ZEUS_APP_LOG}/jjgo.log 2>&1 &
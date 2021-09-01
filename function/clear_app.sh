#!/usr/bin/env bash
app=$1
if [[ -z $app ]];then
  echo "服务名不能为空"
  exit 1
fi

echo "需要清理的服务为${app}"
app_service_dir=${ZEUS_ROOT}/service
if [[ ! -d ${app_service_dir}/$app ]];then
  echo "服务${app}不存在"
  exit 1
fi

# 直接执行clear.sh
${app_service_dir}/$app/clear.sh
if [[ $? == 0 ]];then
  exit 0
else
  exit 1
fi
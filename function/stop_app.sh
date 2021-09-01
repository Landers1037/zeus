#!/usr/bin/env bash

app_name=$1
# find app in zeus service dir
app_dir=${ZEUS_ROOT}/service/${app_name}

if [[ ! -d ${app_dir} ]];then
  echo "服务${app_name}不存在"
  exit 1
fi

# try find stop sh
if [[ ! -f ${app_dir}/stop.sh ]];then
  echo "服务停止脚本不存在"
  exit 1
fi

# try stop app
# 对137 kill 9退出码单独判断
${app_dir}/stop.sh > /dev/null
exit=$?
if [[ $exit != 0 && $exit != 137 ]];then
  echo "服务停止异常"
  exit 1
else
  echo "服务停止完毕"
  exit 0
fi
#!/usr/bin/env bash
# get app status

app_name=$1
# find app in zeus service dir
app_dir=${ZEUS_ROOT}/service/${app_name}

if [[ ! -d ${app_dir} ]];then
  echo "服务${app_name}不存在"
  exit 1
fi

# try find status sh
if [[ ! -f ${app_dir}/status.sh ]];then
  echo "服务状态查询脚本不存在"
  exit 1
fi

${app_dir}/status.sh > /dev/null
if [[ $? == 0 ]];then
  echo "服务正在运行"
else
  echo "服务未在运行"
fi
#!/usr/bin/env bash
# start app by name

app_name=$1
# find app in zeus service dir
app_dir=${ZEUS_ROOT}/service/${app_name}

if [[ ! -d ${app_dir} ]];then
  echo "服务${app_name}不存在"
  exit 1
fi

# try find start sh
if [[ ! -f ${app_dir}/start.sh ]];then
  echo "服务启动脚本不存在"
  exit 1
fi

# try start app
bash ${app_dir}/start.sh
if [[ $? != 0 ]];then
  echo "服务启动异常"
  exit 1
else
  echo "服务启动完毕"
  exit 0
fi
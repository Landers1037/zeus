#!/usr/bin/env bash

# app为空时显示全部注册的app
app=$1
if [[ -z $app ]];then
  service_dir=$ZEUS_ROOT/service
  apps=$(ls ${service_dir})
  for app in ${apps}
  do
    if [[ -d ${service_dir}/${app} ]];then
      echo "(*) ${app}"
    fi
  done
else
  # 读取app的配置文件
  service_dir=$ZEUS_ROOT/service/$app
  if [[ ! -d $service_dir ]];then
    echo "服务${app}不存在"
  else
    echo "$(printf '%-8s' 'APP:') ${app}"
    echo "$(printf '%-8s' 'INFO:') $(cat $service_dir/app_info)"
    echo "$(printf '%-8s' 'VERSION:') $(cat $service_dir/app_version)"
    exit 0
  fi
fi
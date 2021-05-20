#!/usr/bin/env bash
# 注册服务
# 根据模板生成服务的目录 如果目录已经存在表示zeus已经注册 需要先执行删除服务操作
# 服务基于模板生成 由用户手动输入参数进行自定义
# 所有的启动脚本都为初始脚本 需要进一步自定义以满足需求

app=$1
if [[ -z $app ]];then
  echo "服务名不能为空"
  exit 1
fi
app_service_dir=${ZEUS_ROOT}/service
if [[ -d ${app_service_dir}/$app ]];then
  echo "服务$app已经存在"
  exit 1
fi

# 判断all场景重新注册已经存在的服务
if [[ $app == "all" || $app == "A" ]];
then
  echo "开始重新注册全部服务"
  apps=$(ls ${app_service_dir})
  for app in ${apps}
  do
    echo "开始注册服务${app}"
    echo "开始创建服务脚本"
    while read line || [[ -n "$line" ]]
      do
        if [[ ! -f "${app_service_dir}/$app/$line" ]];then
          echo "create cmd $line done..."
          touch ${app_service_dir}/$app/$line
          echo "#!/bin/bash" > ${app_service_dir}/$app/$line
          echo "# cmds for zeus apps" >> ${app_service_dir}/$app/$line
          sleep 0.2
        fi
      done < ${ZEUS_ROOT}/register/cmds

      echo "开始脚本提权"
      # chmod
      chmod +x ${app_service_dir}/$app/*.sh

      # generate template
      cp ${ZEUS_ROOT}/register/service ${app_service_dir}/$app

      # create version info
      echo "开始创建默认版本文件"
      touch ${app_service_dir}/$app/app_version
      echo "v1.0" > ${app_service_dir}/$app/app_version

      echo "开始创建默认服务描述文件"
      touch ${app_service_dir}/$app/app_info
      echo "This is a zeus service" > ${app_service_dir}/$app/app_info

      echo "服务${app}注册完毕"
  done
  exit 0
fi

# start reg
echo "开始初始化服务$app"
# mkdir
mkdir ${app_service_dir}/$app
if [[ $? == 0 ]];then
  echo "服务目录创建完毕${app_service_dir}/$app"
else
  echo "服务目录创建失败"
  exit 1
fi

# touch shell cmds
echo "开始创建服务脚本"
while read line || [[ -n "$line" ]]
do
  if [[ ! -f "${app_service_dir}/$app/$line" ]];then
    echo "create cmd $line done..."
    touch ${app_service_dir}/$app/$line
    echo "#!/bin/bash" > ${app_service_dir}/$app/$line
    echo "# cmds for zeus apps" >> ${app_service_dir}/$app/$line
    sleep 0.2
  fi
done < ${ZEUS_ROOT}/register/cmds

echo "开始脚本提权"
# chmod
chmod +x ${app_service_dir}/$app/*.sh

# generate template
cp ${ZEUS_ROOT}/register/service ${app_service_dir}/$app

# create version info
echo "开始创建默认版本文件"
touch ${app_service_dir}/$app/app_version
echo "v1.0" > ${app_service_dir}/$app/app_version

echo "开始创建默认服务描述文件"
touch ${app_service_dir}/$app/app_info
echo "This is a zeus service" > ${app_service_dir}/$app/app_info

echo "服务${app}创建完毕"
exit 0
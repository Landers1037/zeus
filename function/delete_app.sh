#!/usr/bin/env bash
# delete app from zeus

app=$1
if [[ -z $app ]];then
  echo "服务名不能为空"
  exit 1
fi

echo "需要卸载的服务为${app}"
app_service_dir=${ZEUS_ROOT}/service
if [[ ! -d ${app_service_dir}/$app ]];then
  echo "服务${app}不存在"
  exit 1
fi

# 遍历删除而不是rm -rf
file_list=$(ls ${app_service_dir}/$app)
for file in ${file_list}
do
  echo "start to remove ${file}..."
  rm -f ${app_service_dir}/${app}/${file}
  sleep 0.2
done

rm -rf ${app_service_dir}/${app}
result=$?
echo "服务卸载完毕"
exit ${result}
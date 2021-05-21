#!/usr/bin/env bash
# 日志分割 仅使用在server模式下
if [[ -z ${ZEUS_LOG_ROTATE} || ${ZEUS_LOG_ROTATE} == 0 ]];then
  echo "日志分割: 关闭"
  exit 0
fi
echo "日志分割: 开启"

# 根据时间间隔开启分割
# 根据日志大小开启分割
max_size=104857600 # 100mb
log_size=$(stat -c "%s" ${ZEUS_ROOT}/run.log)

if [[ ! -d ${ZEUS_ROOT}/log ]];then
  mkdir -p ${ZEUS_ROOT}/log
fi

while [ 1 ]
do
  if [[ $log_size -gt $max_size && ${ZEUS_LOG_ROTATE} -gt 0 ]];then
    echo "开始日志分割"
    file_name="log-$(date +%Y-%m-%d)"
    tar -zcvf ${ZEUS_ROOT}/log/$file_name.tar.gz ${ZEUS_ROOT}/run.log
    echo "日志分割完毕 $file_name"
    :> ${ZEUS_ROOT}/run.log
  else
    echo "日志分割监听中 日志大小$log_size"
  fi
  sleep ${ZEUS_LOG_ROTATE}
done

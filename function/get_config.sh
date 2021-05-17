#!/usr/bin/env bash
# 读取环境变量文件
# 最后一行不存在换行符时使用判空条件获取
while read line || [[ -n "$line" ]]
do
  if [[ "$line" =~ ^# ]]
  then
    continue
  else
    env_name=$(echo "$line" | awk '{print $1}')
    env_value=$(echo "$line" | awk '{print $2}')
    echo $env_name=$env_value
  fi
done < ${ZEUS_ROOT}/zeus.env
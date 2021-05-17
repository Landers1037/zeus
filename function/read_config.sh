#!/usr/bin/env bash
# read .env file
# 舍弃带#的注释行
while read line || [[ -n "$line" ]]
do
  if [[ "$line" =~ ^# ]]
  then
    continue
  else
    env_name=$(echo "$line" | awk '{print $1}')
    env_value=$(echo "$line" | awk '{print $2}')
    if [[ -n $env_name && -n $env_value ]];then
      export $env_name=$env_value
    fi
  fi
done < ${ZEUS_ROOT}/zeus.env
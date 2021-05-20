#!/usr/bin/env bash
file=$1
if [[ -z ${file} ]];then
  echo "未指定要编辑的文件默认编辑env"
  echo "[env | template]"
  sleep 2
  if [[ -f ${ZEUS_ROOT}/zeus.env ]];then
    vi ${ZEUS_ROOT}/zeus.env
  else
    echo "env文件不存在"
    exit 1
  fi
else
  # switch
  case $file in
  env|e)
    if [[ -f ${ZEUS_ROOT}/zeus.env ]];then
      vi ${ZEUS_ROOT}/zeus.env
    else
      echo "env文件不存在"
      exit 1
    fi
    ;;
  temp|template)
    if [[ -f ${ZEUS_ROOT}/register/cmds ]];then
      vi ${ZEUS_ROOT}/register/cmds
    else
      echo "template文件不存在"
      exit 1
    fi 
    ;;
  *)
    echo "要编辑的文件非法"
    exit1
    ;;
  esac
fi
#!/usr/bin/env bash
# 初始化权限可执行脚本750
# 模板文件 660
# 其他文件640

if [[ -d ${ZEUS_ROOT}/function ]]
then
chmod -R 750 ${ZEUS_ROOT}/function
fi

if [[ $(ls -A ${ZEUS_ROOT}/function) != "" ]]
then
  chmod 750 ${ZEUS_ROOT}/function/*
fi

if [[ -d ${ZEUS_ROOT}/service ]]
then
  chmod -R 750 ${ZEUS_ROOT}/service
fi

if [[ $(ls -A ${ZEUS_ROOT}/service) != "" ]]
then
  chmod 750 ${ZEUS_ROOT}/service/*
fi

if [[ -d ${ZEUS_ROOT}/register ]]
then
  chmod -R 760 ${ZEUS_ROOT}/register
fi

if [[ $(ls -A ${ZEUS_ROOT}/register) ]]
then
  chmod 760 ${ZEUS_ROOT}/register/*
fi

if [[ -n $(ls *.env) ]]
then
  chmod 640 *.env
fi
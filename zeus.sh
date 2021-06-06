#!/usr/bin/env bash
# zeus app
# zeus负责注册所有的服务为linux服务 并且监控这些服务
# 所有服务的运行脚本放置在service目录下
# register负责放置注册服务的模板

# 首先必须保证应用目录存在
# 程序运行的目录在最开始注册 所有shell共享此变量

# 在任意目录使用zeus时需要下指定zeus_root即zeus的运行时目录
USR_ADD_ZEUS_ROOT=/renj.io/zeus

if [[ -z ${ZEUS_ROOT} ]];then
  # 判断运行目录是否就是zeus目录
  current_dir=$(pwd)
  if [[ -d ${current_dir}/service ]];then
    export ZEUS_ROOT=${current_dir}
  else
    export ZEUS_ROOT=${USR_ADD_ZEUS_ROOT}
  fi
fi

# 初始化脚本权限
${ZEUS_ROOT}/function/init.sh
# 加载所有环境变量
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

# 开始操作
# 没有参数时 输出zeus帮助信息
if [[ -z $1 ]]
then
  ${ZEUS_ROOT}/function/help.sh
  exit 0
fi

# 针对命令分组
case $1 in
help)
  ${ZEUS_ROOT}/function/help.sh
  ;;
watch|w)
  # 根据配置分发不同的监听方式
  args=$*
  args=${args#*" "}
  args_len=$(expr $# - 1)

  if [[ ${ZEUS_WATCH_DOG} == 1 ]];then
    if [[ ${args_len} -gt 0 ]];then
      watch -n ${ZEUS_DURATION} --color -t ${ZEUS_ROOT}/function/run_server_custom_dynamic.sh $args
    else
      watch -n ${ZEUS_DURATION} --color -t ${ZEUS_ROOT}/function/run_server_dynamic.sh
    fi
  else
    if [[ ${args_len} -gt 0 ]];then
      ${ZEUS_ROOT}/function/run_server_custom.sh $args
    else
      ${ZEUS_ROOT}/function/run_server.sh
    fi
  fi
  ;;
reg|register)
  app=$2
  # if empty use read
  if [[ -z $app ]];then
    echo "开始注册服务"
    echo -n "输入需要注册的服务名"
    read app
  else
    echo "开始注册服务${app}"
  fi
  ${ZEUS_ROOT}/function/register_app.sh $app
  ;;
del|delete)
  app=$2
  if [[ -z $app ]];then
    echo "开始卸载服务"
    echo -n "输入需要卸载的服务名"
    read app
  else
    echo "开始卸载服务${app}"
  fi
  ${ZEUS_ROOT}/function/delete_app.sh $app
  ;;
conf|config)
  ${ZEUS_ROOT}/function/get_config.sh
  ;;
temp|template)
  ${ZEUS_ROOT}/function/show_template.sh
  ;;
edit)
  ${ZEUS_ROOT}/function/edit.sh $2
  ;;
start|run)
  app=$2
  if [[ -z "$app" ]];then
    echo "服务名为空"
    exit 0
  else
    ${ZEUS_ROOT}/function/start_app.sh $app
  fi
  ;;
stop)
  app=$2
  if [[ -z "$app" ]];then
    echo "服务名为空"
    exit 0
  else
    ${ZEUS_ROOT}/function/stop_app.sh $app
  fi
  ;;
restart)
  app=$2
  if [[ -z "$app" ]];then
    echo "服务名为空"
    exit 0
  else
    # now is just stop and start
    ${ZEUS_ROOT}/function/stop_app.sh $app
    sleep 1
    ${ZEUS_ROOT}/function/start_app.sh $app
  fi
  ;;
status)
  app=$2
  if [[ -z "$app" ]];then
    echo "服务名为空"
    exit 0
  else
    ${ZEUS_ROOT}/function/status_app.sh $app
  fi
  ;;
clear)
  # use for clear log|cache
  app=$2
  if [[ -z "$app" ]];then
    echo "服务名为空"
    exit 0
  else
    ${ZEUS_ROOT}/function/clear_app.sh $app
    if [[ $? == 0 ]];then
      echo "清理完毕"
    else
      echo "清理失败"
    fi
  fi
  ;;
show)
  app=$2
  ${ZEUS_ROOT}/function/show_app.sh $app
  ;;
*)
  ${ZEUS_ROOT}/function/help.sh
  ;;
esac
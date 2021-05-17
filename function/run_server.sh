#!/usr/bin/env bash
# 生成一个轮询模拟server 监听服务状态
# run可以指定参数运行于后台
ERROR=31
INFO=34
WARN=33
SUCCESS=32
BGAPP=40
BGSYS=41
BGERR=42
BGSTART=43
BGSTOP=44
START="\033["
END="\033[0m"

# 重写一个输出函数 用于确定是否保存日志文件
# $1 title tag数据 表示名称
# 数据的真实高亮在函数传入时已经格式化完毕
function opt()
{
  # 获取时间戳
  now=$(date)
  log_file=$2
  echo -e [$now] "$1"
  if [[ -n "$log_file" ]];then
    echo -e [$now] "$1" >> $log_file
  fi
}

# 输出系统信息
function get_system_status()
{
  data="$(free)"
  opt "${START}${BGSYS}m${data}${END}"
}

# 输出服务信息
function get_app_status()
{
  service_dir=$ZEUS_ROOT/service
  apps=$(find $service_dir/* -maxdepth 0 -type d)
  # 过滤文件夹
  # 遍历所有注册的服务
  if [[ -z "$apps" ]];then
    opt "${START}${BGSYS}m注册的应用为空${END}"
  fi
  # 不为空开始遍历
  for app in $apps
  do
    echo $app
  done
}

# 开始查询

# 结束查询

# 服务启动信息 输入环境变量 日志路径 版本信息

function run_server()
{
  echo "初始化日志文件"
  get_app_status
}

# 支持的参数
# -log 持久化日志到本地
# -time 运行时长 默认循环
# -d 以后台进程运行
# -duration 轮询的时间间隔 默认5s

run_server
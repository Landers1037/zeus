#!/usr/bin/env bash
# 生成一个轮询模拟server 监听服务状态
# run可以指定参数运行于后台
ERROR=31
INFO=34
WARN=33
SUCCESS=32

BGAPP=44
BGSYS=43
BGERR=41
BGSTART=45
BGSTOP=41
BGRUN=47

START="\033["
END="\033[0m"

# real color
# 闪烁
BLINK=5
HIGHLIGHT=1
BLACK=30
RED=31
GREEN=32
YELLOW=33
BLUE=34
PURPLE=35
CYAN=36
WHITE=37

BGBLACK=40
BGRED=41
BGGREEN=42
BGYWLLOW=43
BGBLUE=44
BGPURPLE=45
BGCYAN=46
BGWHITE=47
# 重写一个输出函数 用于确定是否保存日志文件
# $1 type $2 str
# 数据的真实高亮在函数传入时已经格式化完毕
function opt()
{
  # 获取时间戳
  now=$(date "+%Y-%m-%d %H:%M:%S")
  log_file=${ZEUS_ROOT}/run.log
  echo -e [$now] "$1" | tee -a $log_file
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
  opt "${START}${BGSTART};${WHITE}m start to get status of APPS. ${END}"
  service_dir=$ZEUS_ROOT/service
  #  apps=$(find $service_dir/* -maxdepth 0 -type d)
  apps=$(ls ${service_dir})
  # 过滤文件夹
  # 遍历所有注册的服务
  if [[ -z "$apps" ]];then
    opt "${START}${BGSYS}m注册的应用为空${END}"
  fi
  # 不为空开始遍历
  for app in $apps
  do
    status=$(${service_dir}/${app}/status.sh > /dev/null)
    fmt_banner="${START}${BGAPP};${WHITE}m APP ${END}"
    fmt_app="${START}${BGWHITE};${BLACK}m ${app} ${END}"
    if [[ $status == 0 ]];then
      fmt_status="${START}${GREEN};${HIGHLIGHT}m ALIVE ${END}"
      opt "${fmt_banner}${fmt_app} ${fmt_status}"
    else
      fmt_status="${START}${RED};${HIGHLIGHT}m DEAD ${END}"
      opt "${fmt_banner}${fmt_app} ${fmt_status}"
    fi
    sleep 0.05
  done
  opt "${START}${BGSTOP};${WHITE}m status check ends. ${END}"
  opt "wating for the next round."
}

# 开始查询

# 结束查询
get_system_status()
{
  user=$(whoami)
  cpu=$(top -b -n1 | fgrep "Cpu(s)" | tail -1 | awk -F 'id,' '{split($1, vs, ",");v=vs[length(vs)];sub(/\s+/, "" ,v);sub(/\s+/, "", v);printf "%d", 100-v;}')%
  mem=$(free -m | awk -F '[ :]+' 'NR==2{printf "%d", ($3)/$2*100}')%
  disk=$(df -h | grep /$ | awk '{print $5}')
  opt "${START}${WHITE}mcheck system info. ${END}"
  opt "${START}${BGSYS};${WHITE}m system ${END} USER: ${START}${WHITE}m ${user} ${END}"
  opt "${START}${BGSYS};${WHITE}m system ${END} CPU : ${START}${WHITE}m ${cpu} ${END}"
  opt "${START}${BGSYS};${WHITE}m system ${END} MEM : ${START}${WHITE}m ${mem} ${END}"
  opt "${START}${BGSYS};${WHITE}m system ${END} DISK: ${START}${WHITE}m ${disk} ${END}"
}
# 服务启动信息 输入环境变量 日志路径 版本信息

function run_server()
{
  ${ZEUS_ROOT}/function/print_logo.sh
  echo ""
  echo "初始化日志文件"
  echo "默认路径${ZEUS_ROOT}/run.log"

  opt "${START}${BGRUN};${BLACK}m ZEUS SERVER IS RUNNING ${END}"
  opt "ZEUS default duration is: ${START}${CYAN}m${ZEUS_DURATION}s${END}"
  opt "start at time: ${START}${CYAN}m$(date)${END}"
  while [ 1 ]
  do
    get_app_status
    get_system_status
    sleep ${ZEUS_DURATION}
  done
}

# 支持的参数
# -log 持久化日志到本地
# -time 运行时长 默认循环
# -d 以后台进程运行
# -duration 轮询的时间间隔 默认5s

run_server
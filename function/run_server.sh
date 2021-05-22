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

function zeus_powered()
{
  msg="${START}${GREEN}mPOWERED BY ZEUS ${END}"
  for i in {1..40}
  do
    echo -n "="
  done
  echo ""
  echo -n "+"
  echo -n "$(printf %-38s " ")"
  echo -n "+"

  echo ""
  echo -e "+$(printf %-11s " ")${msg}$(printf %-11s " ")+"

  echo -n "+"
  echo -n "$(printf %-38s " ")"
  echo -n "+"
  
  echo ""
  for i in {1..40}
  do
    echo -n "="
  done
  echo ""
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
  # 获取最长的字符串
  max_len=0
  for app in $apps
  do
    if [[ ${#app} -gt ${max_len} ]];then
      max_len=${#app}
    fi
  done
  # 格式化字符串
  for app in $apps
  do
    ${service_dir}/${app}/status.sh > /dev/null 2>&1
    status=$?
    fmt_banner="${START}${BGAPP};${WHITE}m APP ${END}"
    app_str="$(printf %-${max_len}s ${app})"
    fmt_app="${START}${BGWHITE};${BLACK}m ${app_str} ${END}"
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
  opt "waiting for the next round."
  zeus_powered
}

# 开始查询

# 结束查询
get_system_status()
{
  user=$(whoami)
  cpu=$(top -b -n1 | fgrep "Cpu(s)" | tail -1 | awk -F 'id,' '{split($1, vs, ",");v=vs[length(vs)];sub(/\s+/, "" ,v);sub(/\s+/, "", v);printf "%d", 100-v;}')%
  mem=$(free -m | awk -F '[ :]+' 'NR==2{printf "%d", ($3)/$2*100}')%
  disk=$(df -h | grep /$ | awk '{print $5}')
  opt "${START}${PURPLE}mcheck system info. ${END}"
  opt "${START}${BGSYS};${WHITE}m system ${END} USER: ${START}${WHITE}m ${user} ${END}"
  opt "${START}${BGSYS};${WHITE}m system ${END} CPU : ${START}${WHITE}m ${cpu} ${END}"
  opt "${START}${BGSYS};${WHITE}m system ${END} MEM : ${START}${WHITE}m ${mem} ${END}"
  opt "${START}${BGSYS};${WHITE}m system ${END} DISK: ${START}${WHITE}m ${disk} ${END}"
}
# 服务启动信息 输入环境变量 日志路径 版本信息
function print_split()
{
  STR="#"
  for i in {1..20}
  do
    echo -n "$STR"
  done
  echo -n "ZEUS"
  for i in {1..20}
  do
    echo -n "$STR"
  done
  echo ""
}

function init_config()
{
  echo "加载配置文件..."
  if [[ ! -f ${ZEUS_ROOT}/zeus.env ]];then
    echo "配置文件${ZEUS_ROOT}/zeus.env不存在"
    exit 1
  else
    echo "从配置文件${ZEUS_ROOT}/zeus.env中加载配置成功"
  fi
  echo "工作目录${ZEUS_ROOT}"
  echo "服务目录${ZEUS_SERVICE_ROOT}"
}

function init_log()
{
  echo "初始化日志文件"
  echo "默认路径${ZEUS_ROOT}/run.log"
  if [[ -z ${ZEUS_LOG_COVER} || ${ZEUS_LOG_COVER} == 0 ]];then
    echo "日志模式: 追加"
  else
    echo "日志模式: 覆盖"
    echo "" > ${ZEUS_ROOT}/run.log
  fi
}

function stop_log_rotate()
{
  for i in {1..100}
  do
    pid=$(ps ax|grep ${ZEUS_ROOT}/function/log_rotate.sh|grep -v grep|awk '{print $1}')
    if [ -n "$pid" ];then
      kill -9 "${pid}" > /dev/null 2>&1
    else
      break
    fi
  done
  echo "server stopped"
  exit 0
}

function register_stop_server()
{
  trap stop_log_rotate SIGINT
  trap stop_log_rotate INT
  trap stop_log_rotate SIGQUIT
  trap stop_log_rotate SIGTERM
}

function init_log_rotate()
{
  pid=$(ps ax|grep log_rotate|grep -v grep)
  if [[ -z ${pid} ]];then
    ${ZEUS_ROOT}/function/log_rotate.sh > /dev/null &
  fi
}

function setup()
{
  opt "${START}${BGRUN};${BLACK}m ZEUS SERVER IS RUNNING ${END}"
  opt "ZEUS version is: ${START}${CYAN}m${ZEUS_VERSION}${END}"
  opt "ZEUS default duration is: ${START}${CYAN}m${ZEUS_DURATION}s${END}"
  opt "SYSTEM INFO: ${START}${CYAN}m$(uname -o) $(uname -m)${END}"
  opt "Kernel Version: ${START}${CYAN}m$(uname -v)${END}"
}

function start_running()
{
  opt "start at time: ${START}${CYAN}m$(date)${END}"
}

function run_server()
{
  ${ZEUS_ROOT}/function/print_logo.sh
  echo ""
  print_split
  init_config
  init_log
  init_log_rotate
  register_stop_server
  print_split
  setup
  start_running
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
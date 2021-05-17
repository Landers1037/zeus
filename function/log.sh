#!/usr/bin/env bash
# 日志
# 日志级别
ERROR=31
INFO=34
WARN=33
SUCCESS=32
START="\033["
END="\033[0m"

# 通过环境变量获取日志路径 默认为zeus.log
if [[ -z ${ZEUS_LOG_PATH} ]]
then
  log_path=zeus.log
else
  log_path=${ZEUS_ROOT}/${ZEUS_LOG_PATH}
fi

if [[ ! -f $log_path ]]
then
  touch $log_path
fi

function fmt()
{
  color=$1
  data=$2
  echo -e "${START}${color}m${data}${END}" >> $log_path
}

function fmt_to_screen()
{
  color=$1
  data=$2
  echo -e "${START}${color}m${data}${END}"
}

function error()
{
  data=$1
  fmt $ERROR $data
  if [[ -n ${ZEUS_LOG_ECHO} && ${ZEUS_LOG_ECHO} != 0 ]]
  then
    fmt_to_screen $ERROR $data
  fi
}

function info()
{
  data=$1
  fmt $INFO $data
  if [[ -n ${ZEUS_LOG_ECHO} && ${ZEUS_LOG_ECHO} != 0 ]]
  then
    fmt_to_screen $INFO $data
  fi
}

function success()
{
  data=$1
  fmt $SUCCESS $data
  if [[ -n ${ZEUS_LOG_ECHO} && ${ZEUS_LOG_ECHO} != 0 ]]
  then
    fmt_to_screen $SUCCESS $data
  fi
}

level=$1
txt=$2

if [[ -n "$level" && -n "$txt" ]]
then
  case $level in
  error|ERROR)
    error "$txt"
    ;;
  info|INFO)
    info "$txt"
    ;;
  success|SUCCESS)
    success "$txt"
    ;;
  esac
# 其他情况不打印日志
fi
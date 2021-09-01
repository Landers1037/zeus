#!/usr/bin/env bash
for i in {1..100}
do
  pid=$(ps ax|grep app_jjservice|grep -v grep|grep -v zeus|sed -n '1P'|awk '{print $1}')
  if [[ -z $pid ]];then
    break
  else
    kill -9 $pid
  fi
done
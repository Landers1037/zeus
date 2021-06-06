#!/bin/bash
# cmds for zeus apps
# delete nginx cache
if [[ -d $ZEUS_NGINX_CACHE ]];then
  rm -rf ${ZEUS_NGINX_CACHE:?}/*
else
  exit 1
fi
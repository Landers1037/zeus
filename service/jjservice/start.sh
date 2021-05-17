#!/usr/bin/env bash
# jjservice app

cd ${ZEUS_APP_ROOT}/jjservice || exit 1
nohup ./app_jjservice > ${ZEUS_APP_LOG}/jjservice.log 2>&1 &
#!/usr/bin/env bash
# start mysite

cd ${ZEUS_APP_ROOT}/mysite || exit 1
nohup gunicorn -c gun_mysite.py app_mysite:app > ${ZEUS_APP_LOG}/mysite.log 2>&1 &
#!/usr/bin/env bash
# start mgek

cd ${ZEUS_APP_ROOT}/mgek || exit 1
nohup gunicorn -c gun_mgek.py app_mgek:app > ${ZEUS_APP_LOG}/mgek.log 2>&1 &
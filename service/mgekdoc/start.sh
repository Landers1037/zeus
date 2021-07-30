#!/usr/bin/env bash
# mgekdoc is an app

cd ${ZEUS_APP_ROOT}/mgekdoc || exit 1
nohup gunicorn -c gun_mgekdoc.py app_mgekdoc:app > ${ZEUS_APP_LOG}/mgekdoc.log 2>&1 &
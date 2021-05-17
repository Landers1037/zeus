#!/usr/bin/env bash
# jjmail is celery app

cd ${ZEUS_APP_ROOT}/jjmail || exit 1
nohup celery -A jjmail_server worker -l info -f ${ZEUS_APP_LOG}/jjmail.log --pool=solo > /dev/null &
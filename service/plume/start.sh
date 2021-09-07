#!/bin/bash
# cmds for zeus apps

cd ${ZEUS_APP_ROOT}/plume || exit 1
nohup ./plume -port 10024 -eth eth0 -disk vda > ${ZEUS_APP_LOG}/plume.log 2>&1 &
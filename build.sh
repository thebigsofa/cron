#!/bin/bash
echo "Building Cron Image"
docker build -f Dockerfile .  -t bigsofatech/cron:$1
docker push bigsofatech/cron:$1

#!/bin/bash

export PATH=$PATH:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:/usr/local/bundle/bin

echo "Clear the current Crontab"
whenever -c
echo "Update Crontab"
whenever whenever --update-crontab
#this will execute what is send in command line
exec "$@"

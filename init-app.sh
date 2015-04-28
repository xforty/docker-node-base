#!/bin/bash

set -e

cd /srv/app

chown -R app .
setuser app bash -lc 'npm install'

if [ -e /srv/app/Procfile ]
then
  foreman export -t /root/runit -d /srv/app -u app -p 8000 runit /etc/service
fi

if [ -e /srv/app/Gruntfile.* ]
then
  setuser app grunt
fi

if [ -e /srv/app/nginx.conf ] 
then
  cp /srv/app/nginx.conf /etc/nginx/main.d/app.conf
fi

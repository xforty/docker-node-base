#!/bin/sh

cd /srv/app
if [ -x setup ]
then
  setuser app ./setup
fi

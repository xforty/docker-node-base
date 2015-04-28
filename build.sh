#!/bin/sh

exec docker build -t xforty/node-base "`dirname "$0"`"

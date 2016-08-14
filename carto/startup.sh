#!/bin/bash

cd /cartodb
source /usr/local/rvm/scripts/rvm
bundle exec script/restore_redis
bundle exec script/resque > resque.log 2>&1 &
bundle exec rails s -p $PORT


#!/usr/bin/node
require('underscore');
global.settings  = require('./config/settings');
var ENV = process.env.NODE_ENV || 'development';
var env          = require('./config/environments/' + ENV);
env.api_hostname = require('os').hostname().split('.')[0];
global.settings = _.extend(global.settings, env);

var redisConfig = {
    host: global.settings.redis_host,
    port: global.settings.redis_port,
    max: global.settings.redisPool,
    idleTimeoutMillis: global.settings.redisIdleTimeoutMillis,
    reapIntervalMillis: global.settings.redisReapIntervalMillis
};
var metadataBackend = require('cartodb-redis')(redisConfig);
metadataBackend.redisCmd(5, 'HMSET', [
  'rails:users:swc28',
  {
    database_name: 'cartodb_dev_user_swc28_db',
    id: 'swc28',
    database_password: 'some_random_bs',
    map_key: 'some_random_bs',
    database_host: 'postgres',
  }
  ], function(err, data) {
    console.log(err, data)
  })
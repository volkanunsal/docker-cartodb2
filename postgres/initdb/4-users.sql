
CREATE DATABASE cartodb_user_db_user_id_in_redis_db;

CREATE USER cartodb_user_db_user_id_in_redis WITH NOSUPERUSER PASSWORD 'some_random_bs';

GRANT ALL PRIVILEGES ON DATABASE "cartodb_user_db_user_id_in_redis_db" to cartodb_user_db_user_id_in_redis;
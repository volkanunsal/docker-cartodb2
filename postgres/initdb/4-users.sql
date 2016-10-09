
CREATE DATABASE cartodb_dev_user_swc28_db;

CREATE EXTENSION postgis;

CREATE USER development_cartodb_user_swc28 WITH NOSUPERUSER PASSWORD 'some_random_bs';

GRANT ALL PRIVILEGES ON DATABASE "cartodb_dev_user_swc28_db" to development_cartodb_user_swc28;
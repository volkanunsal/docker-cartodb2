#
# Frontend server container
#
FROM ubuntu:14.04
MAINTAINER Volkan Unsal <spocksplanet@gmail.com>

EXPOSE 8080

RUN apt-get update &&\
  apt-get install -y -q --no-install-recommends \
    unzip \
    curl \
    ca-certificates \
  && rm -rf /var/lib/apt/lists/*

# Install Caddy
RUN curl https://getcaddy.com | bash

# Configure Caddy
COPY ./config/Caddyfile /caddy_server/Caddyfile

WORKDIR /caddy_server

# TODO: run the server
CMD ["nohup", "caddy &"]

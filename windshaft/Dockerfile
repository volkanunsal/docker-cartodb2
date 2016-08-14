#
# Windshaft container
#
FROM ubuntu:14.04

# Configuring locales
ENV DEBIAN_FRONTEND noninteractive
RUN dpkg-reconfigure locales && \
      locale-gen en_US.UTF-8 && \
      update-locale LANG=en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

RUN useradd -m -d /home/cartodb -s /bin/bash cartodb &&\
  apt-get update &&\
  apt-get install -y -q \
    build-essential \
    autoconf \
    automake \
    libtool \
    checkinstall \
    git-core \
    git \
    curl \
    libgeos-c1 \
    libgeos-dev \
    libjson0 \
    python-simplejson \
    libjson0-dev \
    proj-bin \
    proj-data \
    libproj-dev \
    gdal-bin \
    libgdal1-dev \
    ca-certificates \
    python2.7-dev \
    python-setuptools \
    imagemagick \
    libmapnik-dev \
    mapnik-utils \
    python-mapnik \
    python-argparse \
    python-gdal \
    python-chardet \
    openssl \
    libreadline6 \
    zlib1g \
    zlib1g-dev \
    libssl-dev \
    libyaml-dev \
    libsqlite3-dev \
    sqlite3 \
    libxml2-dev \
    libxslt-dev \
    libc6-dev \
    ncurses-dev \
    bison \
    pkg-config \
    libpq5 \
    libpq-dev \
    libcurl4-gnutls-dev \
    libffi-dev \
    libgdbm-dev \
    gnupg \
    libreadline6-dev \
    libcairo2-dev \
    libjpeg8-dev \
    libpango1.0-dev \
    libgif-dev \
    libgmp-dev \
    libicu-dev \
  --no-install-recommends &&\
  rm -rf /var/lib/apt/lists/*

RUN git config --global user.email spocksplanet@gmail.com
RUN git config --global user.name "Volkan Unsal"

# Install NodeJS
RUN curl https://nodejs.org/download/release/v0.10.41/node-v0.10.41-linux-x64.tar.gz| tar -zxf - --strip-components=1 -C /usr

# Install NPM
RUN npm install -g npm@1.4.29

# Install Windshaft
RUN git clone git://github.com/CartoDB/Windshaft-cartodb.git
WORKDIR /Windshaft-cartodb
RUN git reset --hard 03991319683452956ad5ceb2a1c95a452dbf3428 &&\
  ./configure && npm install && mkdir logs

# Assume the following linked services
# - postgres:5432
# - redis:6379
# - varnish:6082  // <- port to telnet interface
# - varnish:6081 // <- port to HTTP interface
# - statsd:8125
ADD ./config/WS-dev.js \
      /Windshaft-cartodb/config/environments/development.js

EXPOSE 8181

MAINTAINER Volkan Unsal <spocksplanet@gmail.com>
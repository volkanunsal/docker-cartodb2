#
# Postgres container
#
FROM ubuntu:14.04
MAINTAINER Volkan Unsal <spocksplanet@gmail.com>

# Configuring locales
ENV DEBIAN_FRONTEND noninteractive
RUN dpkg-reconfigure locales && \
      locale-gen en_US.UTF-8 && \
      update-locale LANG=en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# Configure Postgres
ENV PG_MAJOR 9.3
ENV POSTGIS_MAJOR 2.1

# Install prerequisite software packages
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
      wget \
      build-essential \
      autoconf \
      automake \
      libtool \
      checkinstall \
      git-core \
      git \
      "postgresql-plpython-$PG_MAJOR" \
      python2.7-dev \
      python-setuptools \
      libpq-dev \
      "postgresql-client-$PG_MAJOR" \
      "postgresql-contrib-$PG_MAJOR" \
      "postgresql-server-dev-$PG_MAJOR" \
      "postgresql-plpython-$PG_MAJOR" \
      "postgresql-$PG_MAJOR-plproxy" \
      "postgresql-$PG_MAJOR-postgis-$POSTGIS_MAJOR" \
      "postgresql-$PG_MAJOR-postgis-$POSTGIS_MAJOR-scripts" \
      postgis \
      pgtune \
      ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Install gosu
RUN export ARCH \
    && export GOSU_VERSION \
    && GOSU_VERSION=1.7 \
    && ARCH="$(dpkg --print-architecture)" \
    && export GNUPGHOME \
    && GNUPGHOME="$(mktemp -d)" \
    && wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$ARCH" \
    && wget -O /usr/local/bin/gosu.asc "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$ARCH.asc" \
    && gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 \
    && gpg --batch --verify /usr/local/bin/gosu.asc /usr/local/bin/gosu \
    && rm -r "$GNUPGHOME" /usr/local/bin/gosu.asc \
    && chmod +x /usr/local/bin/gosu \
    && gosu nobody true

# Configure Git
RUN git config --global user.email user@example.com
RUN git config --global user.name "User"

# Install schema_triggers
RUN git clone https://github.com/CartoDB/pg_schema_triggers.git
WORKDIR /pg_schema_triggers
RUN git reset --hard abe8d722dd6cfa447e1d19dc90c2065949c7cb10 &&\
  make all install

# Install cartodb extension
RUN git clone https://github.com/CartoDB/cartodb-postgresql.git /cartodb-postgresql
WORKDIR /cartodb-postgresql
RUN git reset --hard 415d96082e5b6cef72299fef89d4f170d911aa02 &&\
  PGUSER=postgres make install

# Any file in this directory is run automatically by docker-entrypoint.sh
RUN mkdir -p /docker-entrypoint-initdb.d

# ---- postgres config variables --------
ENV PATH /usr/lib/postgresql/$PG_MAJOR/bin:$PATH
ENV PGDATA /var/lib/postgresql/data
# ENV POSTGRES_DB carto
# ENV POSTGRES_USER carto
# ENV POSTGRES_PASSWORD carto

# Mount shared drive
VOLUME /var/lib/postgresql/data

# Copy entrypoint
COPY docker-entrypoint.sh /
COPY ./initdb/*.sh /docker-entrypoint-initdb.d/

EXPOSE 5432

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["postgres"]

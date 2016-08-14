#
# Cartodb container
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
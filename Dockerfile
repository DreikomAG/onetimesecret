# Dockerfile for One-Time Secret
# http://onetimesecret.com

FROM ruby:2.3

# Install dependencies
RUN DEBIAN_FRONTEND=noninteractive \
  apt-get update && \
  apt-get install -y \
    build-essential \
    redis-server \
  && rm -rf /var/lib/apt/lists/*

# Download and install OTS version 0.10.x

#Add Source Code to Build
ADD . /var/lib/onetime

RUN set -ex && \
  mkdir -p /etc/onetime /var/log/onetime /var/run/onetime /var/lib/onetime && \
  cd /var/lib/onetime && \
  bundle install --frozen --deployment --without=dev && \
  cp -R etc/* /etc/onetime/

ADD docker-entrypoint.sh /usr/bin/

VOLUME /var/lib/redis

EXPOSE 7143/tcp

ENTRYPOINT ["sh", "/usr/bin/docker-entrypoint.sh"]

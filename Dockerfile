# Inspired by 
#   https://github.com/owncloud-docker/litmus

FROM alpine:edge

# ENTRYPOINT ["/usr/local/bin/litmus-wrapper"]
ENTRYPOINT ["/usr/local/bin/litmus"]

# Pimp alpine installation
RUN apk update && \
  apk upgrade && \
  apk add \
    ca-certificates \
    bash \
    vim \
    curl \
    wget \
    bzip2 \
    unzip \
    ncurses \
    tar \
    shadow \
    su-exec \
    git && \
  rm -rf /var/cache/apk/*

# Download and build litmus
RUN apk update && \
  apk upgrade && \
  apk add build-base openssl-dev openssl && \
  wget -q -O - https://github.com/eanlain/litmus/releases/download/v0.13/litmus-0.13.tar.gz | tar xzvf - -C /tmp && \
  cd /tmp/litmus-0.13 && \
  ./configure --with-ssl && \
  make && \
  PREFIX=/usr make install && \
  cd && \
  apk del build-base openssl-dev && \
  rm -rf /var/cache/apk/* /tmp/*

WORKDIR /root
COPY rootfs /

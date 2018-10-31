FROM ruby:alpine3.8

RUN apk update && apk upgrade && apk --update --no-cache add \
  openrc \
  cmake \
  clang \
  clang-dev \
  make \
  gcc \
  g++ \
  libc-dev \
  linux-headers \
  libcurl \
  git \
  bash \
  openssl \
  openssl-dev \
  tzdata

#TODO: bundle install system-wide

COPY ./dataspects_lib /tmp/dataspects_lib
WORKDIR /tmp/dataspects_lib
RUN bundle install

COPY ./dataspects_api /tmp/dataspects_api
WORKDIR /tmp/dataspects_api
RUN bundle install

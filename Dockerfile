# syntax=docker/dockerfile:1
# check=error=true

FROM ruby:3.4.2
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y curl libjemalloc2 libvips sqlite3 && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives
WORKDIR /app
ADD . /app
RUN mkdir -p /vendor/bundle
ENV BUNDLE_GEMFILE=/app/Gemfile BUNDLE_PATH=/vendor/bundle
RUN bundle install

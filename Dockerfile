# syntax = docker/dockerfile:1

ARG RUBY_VERSION=3.1.4
FROM registry.docker.com/library/ruby:$RUBY_VERSION-slim as base

WORKDIR /rails

ENV RAILS_ENV="development" \
  BUNDLE_DEPLOYMENT="0" \
  BUNDLE_PATH="/usr/local/bundle" \
  BUNDLE_WITHOUT=""

RUN apt-get update -qq && apt-get install -y nodejs yarn git libgmp-dev libpq-dev postgresql-client postgresql build-essential libxslt-dev libxml2-dev

COPY Gemfile* ./

RUN bundle install

COPY . .

COPY docker-entrypoint.sh .
RUN chmod +x docker-entrypoint.sh
ENTRYPOINT ["./docker-entrypoint.sh"]

CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]

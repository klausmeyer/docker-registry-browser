FROM ruby:2.3-alpine

MAINTAINER Klaus Meyer <spam@klaus-meyer.net>

ENV PORT 8080
ENV RAILS_ENV production
ENV SECRET_KEY_BASE changeme

EXPOSE 8080

RUN apk update && \
    apk add build-base zlib-dev libxml2-dev libxslt-dev tzdata yaml-dev git nodejs && \
    rm -rf /var/cache/apk/*

ADD . /app
WORKDIR /app

RUN gem install bundler && \
    gem install -N nokogiri -- --use-system-libraries && \
    bundle install --without development test && \
    rake assets:precompile && \
    rm -rf /usr/lib/lib/ruby/gems/*/cache/*

CMD bundle exec puma -C config/puma.rb


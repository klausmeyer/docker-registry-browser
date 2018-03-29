FROM ruby:2.5.1-alpine

MAINTAINER Klaus Meyer <spam@klaus-meyer.net>

ENV PORT 8080
ENV RAILS_ENV production
ENV SECRET_KEY_BASE changeme
ENV RAILS_SERVE_STATIC_FILES true
ENV RAILS_LOG_TO_STDOUT true

EXPOSE 8080

RUN   apk update \
  &&  apk add build-base zlib-dev libxml2-dev libxslt-dev tzdata yaml-dev git nodejs \
  &&  rm -rf /var/cache/apk/*

WORKDIR /app

ADD Gemfile /app
ADD Gemfile.lock /app

RUN   gem install bundler \
  &&  bundle install --without development test

ADD . /app

RUN adduser -S -h /app app && chown -R app /app && chown -R app /usr/local/bundle

USER app

RUN rake assets:precompile && \
    rm -rf /usr/lib/lib/ruby/gems/*/cache/*

CMD puma -C config/puma.rb

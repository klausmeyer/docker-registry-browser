FROM ruby:2.3.1-alpine

MAINTAINER Klaus Meyer <spam@klaus-meyer.net>

ENV PORT 8080
ENV RAILS_ENV production
ENV SECRET_KEY_BASE changeme
ENV RAILS_SERVE_STATIC_FILES true
ENV RAILS_LOG_TO_STDOUT true

EXPOSE 8080

ADD . /app
RUN adduser -S -h /app app && chown -R app /app && chown -R app /usr/local/bundle

RUN apk update && \
    apk add build-base zlib-dev libxml2-dev libxslt-dev tzdata yaml-dev git nodejs && \
    rm -rf /var/cache/apk/*

USER app
WORKDIR /app

RUN gem install bundler && \
    bundle install --without development test && \
    rake assets:precompile && \
    rm -rf /usr/lib/lib/ruby/gems/*/cache/*

CMD bundle exec puma -C config/puma.rb

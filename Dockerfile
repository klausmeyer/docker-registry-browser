FROM ruby:3.2.0-alpine

MAINTAINER Klaus Meyer <spam@klaus-meyer.net>

ARG SOURCE_COMMIT
ENV SOURCE_COMMIT $SOURCE_COMMIT

ENV PORT 8080
ENV SSL_PORT 8443
ENV RAILS_ENV production
ENV SECRET_KEY_BASE changeme
ENV RAILS_SERVE_STATIC_FILES true
ENV RAILS_LOG_TO_STDOUT true

EXPOSE $PORT
EXPOSE $SSL_PORT

WORKDIR /app

ADD . .

RUN apk update \
 && apk add build-base zlib-dev tzdata nodejs openssl-dev shared-mime-info libc6-compat \
 && rm -rf /var/cache/apk/* \
 && gem install bundler -v $(tail -n1 Gemfile.lock | xargs) \
 && bundle config set build.sassc '--disable-march-tune-native' \
 && bundle config set without 'development test' \
 && bundle install \
 && bundle exec rails assets:precompile \
 && addgroup -S app && adduser -S app -G app -h /app \
 && chown -R app.app /app \
 && chown -R app.app /usr/local/bundle

USER app

CMD puma -C config/puma.rb

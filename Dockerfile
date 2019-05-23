FROM ruby:2.6.3-alpine

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
&& apk add build-base zlib-dev tzdata nodejs yarn openssl-dev \
&& rm -rf /var/cache/apk/* \
&& gem install bundler \
&& bundle install --without development test \
&& adduser -S -h /app app \
&& chown -R app /app \
&& chown -R app /usr/local/bundle \
&& bundle exec rake assets:precompile \
&& apk del build-base yarn

USER app

CMD puma -C config/puma.rb

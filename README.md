# Docker Registry Browser

Web Interface for the [Docker Registry HTTP API V2](https://docs.docker.com/registry/spec/api/) written in Ruby on Rails.

## Screenshots

Repositories overview

[![Screenshot 1](https://github.com/klausmeyer/docker-registry-browser/raw/master/docs/screenshot1_thumb.png "Screenshot 1: Repositories overview")](https://github.com/klausmeyer/docker-registry-browser/raw/master/docs/screenshot1.png)

## Usage

### Docker

Execute:

```
docker run --name registry-browser -it -p 8080:8080 -e DOCKER_REGISTRY_URL=http://your-registry:5000 klausmeyer/docker-registry-browser
```

### Manual setup

1. Install ruby 2.3.x e.g. using [RVM](http://rvm.io)
2. Execute `gem install bundler && bundle install --without development test` inside your local clone of this repository
3. Run the application using `DOCKER_REGISTRY_URL=http://your-registry:5000 bundle exec bundle exec puma -C config/puma.rb`
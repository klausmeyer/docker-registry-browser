# Docker Registry Browser

[![Build Status](https://travis-ci.org/klausmeyer/docker-registry-browser.svg?branch=master)](https://travis-ci.org/klausmeyer/docker-registry-browser)

Web Interface for the [Docker Registry HTTP API V2](https://docs.docker.com/registry/spec/api/) written in Ruby on Rails.

## Screenshots

Repositories overview

[![Screenshot 1](https://github.com/klausmeyer/docker-registry-browser/raw/master/docs/screenshot1_thumb.png "Screenshot 1")](https://github.com/klausmeyer/docker-registry-browser/raw/master/docs/screenshot1.png)

Tag overview

[![Screenshot 2](https://github.com/klausmeyer/docker-registry-browser/raw/master/docs/screenshot2_thumb.png "Screenshot 2")](https://github.com/klausmeyer/docker-registry-browser/raw/master/docs/screenshot2.png)

Tag details - part 1

[![Screenshot 3](https://github.com/klausmeyer/docker-registry-browser/raw/master/docs/screenshot3_thumb.png "Screenshot 3")](https://github.com/klausmeyer/docker-registry-browser/raw/master/docs/screenshot3.png)

Tag details - part 2

[![Screenshot 4](https://github.com/klausmeyer/docker-registry-browser/raw/master/docs/screenshot4_thumb.png "Screenshot 4")](https://github.com/klausmeyer/docker-registry-browser/raw/master/docs/screenshot4.png)

Delete tag

[![Screenshot 5](https://github.com/klausmeyer/docker-registry-browser/raw/master/docs/screenshot5_thumb.png "Screenshot 5")](https://github.com/klausmeyer/docker-registry-browser/raw/master/docs/screenshot5.png)

## Usage

### Docker

Execute:

```
docker run --name registry-browser -it -p 8080:8080 -e DOCKER_REGISTRY_URL=http://your-registry:5000 klausmeyer/docker-registry-browser
```

### Manual setup

1. Install ruby e.g. using [RVM](http://rvm.io) (see `.ruby-version` file for required version).
2. Execute `gem install bundler && bundle install --without development test` inside your local clone of this repository
3. Run the application using `DOCKER_REGISTRY_URL=http://your-registry:5000 bundle exec bundle exec puma -C config/puma.rb`

## Configuration

The configuration is done by environment variables.

| Option               | Required | Type   | Example                   | Description                                               |
| -------------------- | -------- | ------ | ------------------------- | --------------------------------------------------------- |
| DOCKER_REGISTRY_URL  | yes      | String | http://your-registry:5000 | URL to the Docker Registry which should be browsed        |
| NO_SSL_VERIFICATION  | no       | Bool   | true                      | Enable to skip SSL verification (default `false`)         |
| BASIC_AUTH_USER      | no       | String | joe                       | Username for basic-auth against registry                  |
| BASIC_AUTH_PASSWORD  | no       | String | supersecretpassw0rd       | Password for basic-auth against registry                  |
| ENABLE_DELETE_IMAGES | no       | Bool   | true                      | Allow deletion of tags (default `false`)                  |

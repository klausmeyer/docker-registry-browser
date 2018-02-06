# Docker Registry Browser

[![Build Status](https://travis-ci.org/klausmeyer/docker-registry-browser.svg?branch=master)](https://travis-ci.org/klausmeyer/docker-registry-browser)

Web Interface for the [Docker Registry HTTP API V2](https://docs.docker.com/registry/spec/api/) written in Ruby on Rails.

## Screenshots

Repositories overview

[![Screenshot 1](https://github.com/klausmeyer/docker-registry-browser/raw/master/docs/screenshot1_thumb.png "Screenshot 1")](https://github.com/klausmeyer/docker-registry-browser/raw/master/docs/screenshot1.png)

Tag overview

[![Screenshot 2](https://github.com/klausmeyer/docker-registry-browser/raw/master/docs/screenshot2_thumb.png "Screenshot 2")](https://github.com/klausmeyer/docker-registry-browser/raw/master/docs/screenshot2.png)

Tag details

[![Screenshot 3](https://github.com/klausmeyer/docker-registry-browser/raw/master/docs/screenshot3_thumb.png "Screenshot 3")](https://github.com/klausmeyer/docker-registry-browser/raw/master/docs/screenshot3.png)

Delete tag

[![Screenshot 4](https://github.com/klausmeyer/docker-registry-browser/raw/master/docs/screenshot4_thumb.png "Screenshot 4")](https://github.com/klausmeyer/docker-registry-browser/raw/master/docs/screenshot4.png)

## Usage

### Docker

Execute:

```
docker run --name registry-browser -it -p 8080:8080 -e DOCKER_REGISTRY_URL=http://your-registry:5000 klausmeyer/docker-registry-browser
```

### Manual setup

1. Install ruby e.g. using [RVM](http://rvm.io)<br>(see `.ruby-version` file for required version).
2. Execute the following command inside your local clone of this repository:<br>`gem install bundler && bundle install --without development test`
3. Run the application using<br>`DOCKER_REGISTRY_URL=http://your-registry:5000 bundle exec bundle exec puma -C config/puma.rb`

## Configuration

The configuration is done by environment variables.

| Option                 | Required | Type   | Description                                                                                    |
| ---------------------- | -------- | ------ | ---------------------------------------------------------------------------------------------- |
| `DOCKER_REGISTRY_URL`  | yes      | String | URL to the Docker Registry which should be browsed<br>**Example**: `http://your-registry:5000` |
| `NO_SSL_VERIFICATION`  | no       | Bool   | Enable to skip SSL verification (default `false`)<br>**Example**: `true`                       |
| `BASIC_AUTH_USER`      | no       | String | Username for basic-auth against registry<br>**Example**: `joe`                                 |
| `BASIC_AUTH_PASSWORD`  | no       | String | Password for basic-auth against registry<br>**Example**: `supersecretpassw0rd`                 |
| `ENABLE_DELETE_IMAGES` | no       | Bool   | Allow deletion of tags (default `false`)<br>**Example**: `true`                                |
| `PUBLIC_REGISTRY_URL`  | no       | String | The public URL to the Docker Registry to do docker pull<br>**Example**: `your-registry:5000`   |

You can also set `BASIC_AUTH_USER` and `BASIC_AUTH_PASSWORD` as [Docker Swarm secrets](https://docs.docker.com/engine/swarm/secrets/).

### Proxy Setups

If you're using a reverse-proxy setup with SSL termination in front of this application in combination with `ENABLE_DELETE_IMAGES=true` you must make sure that the application knows about this fact (by sending `X-Forwarded-Proto: https` in the HTTP headers).

Otherwise the application would throw errors like `"HTTP Origin header [...] didn't match request.base_url [...]"` when you're trying to delete image-tags.

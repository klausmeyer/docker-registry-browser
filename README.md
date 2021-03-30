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

```shell
$ docker run --name registry-browser -p 8080:8080 klausmeyer/docker-registry-browser
```

Please have a look at the [Documentation](docs/README.md) for more details and available configuration options.

## Licence

The application is available as open source under the terms of the MIT License.




# Documentation

## Goals / Design

This application aims to be a easy to install and simple user interface for selfhosted docker registries.

In contrast to other solutions it doesn't keep any state and therefore does not require an own database or tight integration into the registry backend and can be added on top of already existing registries.

This also brings some limitations as the API exposed by docker registries simply does not support things like advanced filtering or searching. Also there is no plan to integrate features like user management or audit features.

## Installation

The recommended way of installing this application is by using the [official docker-image](https://hub.docker.com/r/klausmeyer/docker-registry-browser/):

```shell
$ docker run --name registry-browser -p 8080:8080 klausmeyer/docker-registry-browser
```

It is also possible to manually install the application. For this you'll need to manually install the required ruby version (see `.ruby-version` file) and setup the dependencies via [bundler](https://bundler.io).

## Configuration

The following configuration options are supported by the application and can be set as environment variables.

### Basic Application Settings

### HTTP

#### `ADDRESS`

This option allows to define on which ip-address / interfaces the application should listen on.

Default: `0.0.0.0` (all interfaces)

#### `PORT`

This options allows to define on which port the application should listen on.

Default: `8080`

#### `RAILS_RELATIVE_URL_ROOT` / `SCRIPT_NAME`

This options allow to run the application in a subfolder.

Please have a look at the examples about details.

Default: Not used

### HTTPS & TLS/SSL

It is possible to use the built-in application server for the handling of encrypted HTTP requests.

But please note that this is not the recommended way. Consider using a reverse proxy like [nginx][nginx] or [traefik][traefik].

SSL mode is enabled when both certificate and key path variables are defined.

#### `SSL_ADDRESS`

This options allows to define on which ip-address / interfaces the application should listen on.

Default: `0.0.0.0` (all interfaces)

#### `SSL_PORT`

This option allows to define on which port the application should listen on.

Default: `8443`

#### `SSL_CERT_PATH`

This option defines where the application will load it's SSL certificate from.

Default: Not used

#### `SSL_KEY_PATH`

This option defines where the application will load it's SSL key from.

Default: Not used

### Features / User Interface

#### `ENABLE_COLLAPSE_NAMESPACES`

This option will enable collapsed namespaces on repository list.

Default: `false`

#### `ENABLE_DELETE_IMAGES`

This option will enable the delete button for image-tags.

Please note that this button will only work when the delete feature is also enabled in the actual docker registry.

See https://docs.docker.com/registry/configuration/#delete for details.

Default: `false`

#### `SORT_TAGS_BY`

This option allows to define the default sort criteria for the tags list.

It is used whenever the user has no custom selection (cookie).

Possible values:

* `api`: Keep the sort as provided by the registry API
* `name`: Sort the tags in alphabetical order
* `version`: Sort the tags by interpreting them as version numbers

Default: `name`

#### `SORT_TAGS_ORDER`

This option allows to define the default sort order for the tags list.

It is used whenever the user has no custom selection (cookie).

Possible values:

* `asc`: Normal sort order
* `desc`: Inverse sort order

Default: `desc`

### Connection to the Registry

#### `DOCKER_REGISTRY_URL`

This option defines how the application will connect to the docker-registry API.

Default: `http://localhost:5000`

#### `NO_SSL_VERIFICATION`

This option defines if the application will skip validation for SSL certificates used by the docker-registry API.

Default: `false`

#### `CA_FILE`

This option allows to define a custom CA file which the application will use to check certificates used by the docker-registry API.

Default: Not used

#### `PUBLIC_REGISTRY_URL`

This option allows to set a public version of the docker registry URL and will be used to show custom `docker pull` commands.

Please note that this value should only contain the domain and port part of the URL. Example: `registry.example.com:5000`.

Default: Not used

#### Logging

See [Registry Request Logging](#registry-request-logging)

### Authentication

The application automatically detects if the docker-registry API requires authentication and forwards that request to the web-browser. As an alternative it's also possible to configure static values to be used in the authentication to allow access with the permissions of an specific user.

The token based authentication has been tested with the official docker [registry](https://docs.docker.com/registry/spec/auth/token/) and [cesanta/docker_auth](https://github.com/cesanta/docker_auth).

#### `BASIC_AUTH_USER`

This options allows to define the username used for HTTP basic authentication against the docker-registry API.

Default: Not used

#### `BASIC_AUTH_PASSWORD`

This options allows to define the password used for HTTP basic authentication against the docker-registry API.

Default: Not used

#### `TOKEN_AUTH_USER`

This options allows to define the username used for token based authentication against the docker-registry API.

Default: Not used

#### `TOKEN_AUTH_PASSWORD`

This options allows to define the password used for token based authentication against the docker-registry API.

Default: Not used

# Troubleshooting

A few common issues and how to solve them:

### Can't delete image tags

Please make sure that you hvae enabled the image deletion in your docker-registry [configuration](https://docs.docker.com/registry/configuration/#delete) and that your reverse-proxy setup sets the `X-Forwarded-Proto` header in case it's stripping the SSL/TLS connection down to plain HTTP when talking to the application.

# Examples

Following a few examples showing different usecases and their setup.

## Subfolder

In case you want to have both the docker-registry API and the docker-registry-browser exposed on the same host it is possible to tell the application to run in a sub-directory. Just set the `SCRIPT_NAME` and `RAILS_RELATIVE_URL_ROOT` variables like the following:

```yaml
registry-browser:
  image: "klausmeyer/docker-registry-browser"
  ports:
    - "8080:8080"
  environment:
    SCRIPT_NAME: "/browser"
    RAILS_RELATIVE_URL_ROOT: "/browser"
```

In your reverse proxy it's important to make sure the proxied request doesn't contain the name of the subfolder.

### Example: Nginx (Standalone)

Make sure to add a `/` at the end of the URL used in the `proxy_pass` directive.

```nginx
server {
  listen 8000;
  server_name 127.0.0.1;

  root /usr/local/var/www;

  location /browser/ {
    proxy_pass http://127.0.0.1:8080/; # Important: Don't remove the `/` at the end.
  }

  location /v2/ {
    proxy_pass http://127.0.0.1:5000;
  }
}
```

### Example: Nginx Ingress Controller (k8s):

Add a `rewrite-target` to avoid the path being proxied to the application.

```yaml
---
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /$1
  name: docker-registry-browser
  namespace: docker-registry
spec:
  rules:
  - host: registry.example.com
    http:
      paths:
      - pathType: Prefix
        path: /browser/(.*)
        backend:
          service:
            name: docker-registry-browser
            port:
              number: 8080
```

### Example: Traefik

Use a custom middleware to avoid proxying the path to the application.

```yaml
labels:
  - 'traefik.http.middlewares.browser-stripprefix.stripprefix.prefixes=/browser'
  - 'traefik.http.routers.browser.rule=PathPrefix(`/browser`)'
  - 'traefik.http.routers.browser.middlewares=browser-stripprefix@browser'
```

## Token Authentication

The following example was used to test the token based authentication feature.

Replace `192.168.178.125` with your actual ip-address.

```yaml
version: '3'

services:

  auth:
    image: cesanta/docker_auth:1
    command: --v=2 --alsologtostderr /auth.yaml
    volumes:
      - './files/auth.yaml:/auth.yaml:ro'
      - './files/server.pem:/server.pem:ro'
      - './files/server.key:/server.key:ro'
    ports:
      - '5001:5001'

  registry:
    image: registry:2
    environment:
      - 'REGISTRY_AUTH_TOKEN_REALM=https://192.168.178.125:5001/auth'
      - 'REGISTRY_AUTH_TOKEN_SERVICE=Docker registry'
      - 'REGISTRY_AUTH_TOKEN_ISSUER=www.example.com'
      - 'REGISTRY_AUTH_TOKEN_ROOTCERTBUNDLE=/server.pem'
      - 'REGISTRY_HTTP_TLS_CERTIFICATE=/server.pem'
      - 'REGISTRY_HTTP_TLS_KEY=/server.key'
    volumes:
      - './files/server.pem:/server.pem:ro'
      - './files/server.key:/server.key:ro'
    ports:
      - '5000:5000'

  frontend:
    image: klausmeyer/docker-registry-browser:latest
    environment:
      - 'DOCKER_REGISTRY_URL=https://registry:5000'
      - 'NO_SSL_VERIFICATION=true'
      - 'TOKEN_AUTH_USER=admin'
      - 'TOKEN_AUTH_PASSWORD=badmin'
      - 'SSL_CERT_PATH=/server.pem'
      - 'SSL_KEY_PATH=/server.key'
    volumes:
      - './files/server.pem:/server.pem:ro'
      - './files/server.key:/server.key:ro'
    ports:
      - '8443:8443'
```

[nginx]: https://www.nginx.com
[traefik]: https://traefik.io/traefik/

## Logging

### Registry Request Logging

By default, basic information about requests to the registry, such as HTTP method and url, are 
logged at the `:info` level.

For debugging, you can change two aspects via environment variables:

* `REGISTRY_LOG_LEVEL` - set the log level used to write registry request (and response) events
* `REGISTRY_LOG_HEADERS` - boolean - enables logging request headers

Due to sensitive data being present in Authorization headers, do not enable header logging in production.

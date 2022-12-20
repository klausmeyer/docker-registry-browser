# Changelog

# v1.6.0

* Handle case of missing `history` attribute in tag response
* Allow `version` for `SORT_TAGS_BY` environment variable
* Turn off Faraday HTTP request header logging
  * Add environment variable `REGISTRY_LOG_LEVEL` to set log level Faraday uses when writing registry related log events
  * Add environment variable `REGISTRY_LOG_HEADERS` to enable Faraday to log HTTP request headers
* Update to Ruby 3.1.3
* Update to Rails 7.0.4

# v1.5.0

* Handle `null` value in `repositories` property of `/v2/_catalog`
* Add `GET /ping` endpoint for health-checks
* Allow to sort tags
* Add Favicon
* Docker image: Remove `yarn`, Add `libc6-compat`
* Add total manifest size on details page
* Multiarch improvements: show variant & sort
* Also build armv7 images (32bit ARM)
* Fix delete when using token auth
* Update to Ruby 3.1.2
* Update to Rails 7.0.3

# v1.4.0

* Support for multi arch docker images
* Support for oci image format
* Option for collapsed namespaces
* Handle errors on tage delete gracefully
* Support token based auth without hardcoded credentials
* Available as `linux/amd64` and `linux/arm64` on hub.docker.com
* Update to Ruby 3.0.2
* Update to Rails 6.1.4.1

# v1.3.5

* Update to Ruby 2.7.2
* Update to Rails 6.0.3.4
* Gracefully handle token auth issues
* Use ca_file option when obtaining auth token

# v1.3.4

* Fix issue in puma config.

# v1.3.3

* Add new `CA_FILE` option to configure CA for SSL backends
* Update to Rails 6.0.2.2
* Update to Ruby 2.6.6
* Update to Faraday 1.0

# v1.3.2

* Improve token auth support

# v1.3.1

* Update to Rails 6.0.2
* Allow Faraday to follow remote redirects
* Support registries returning json header for blob requests

# v1.3.0

* Update to Ruby 2.6.5 and Rails 6.0.1
* Add `ADDRESS` and `SSL_ADDRESS` options
* Fix an `Illegal instruction` ruby error related to sassc
* Show more details on the tag page (Labels, ENVs, Created Date, ...)

# v1.2.3

* Security fix for nokogiri CVE-2019-5477

# v1.2.2

* Improve warning text for delete tag button

# v1.2.1

* Fix tag delete button for special tag names (like `null`)

# v1.2.0

* Support for standalone SSL

# v1.1.2

* Update to Ruby 2.6.3 and Rails 5.2.3
* Support for links in `/example:latest` format (via redirect)

# v1.1.1

* Update to Ruby 2.6.2 and Rails 5.2.2.1

# v1.1.0

* Support for token based authentication
* Update of used libraries

# v1.0.1

* Reduce size of docker image
* Update of Ruby interpreter to 2.6.0 and some used libraries
* Stop hotlinking of icons from external domain icons8.com

# v1.0.0

* Started versioning the application

Features so far:

* Browse images (by namespace) and their tags
* Delete tags
* Copy & paste of docker pull commands
* Authenticiation with HTTP basic auth or token based authentication against registry

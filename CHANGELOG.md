# Changelog

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

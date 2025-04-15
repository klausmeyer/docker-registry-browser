# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true

pin "bootstrap" # @5.3.5
pin "@popperjs/core", to: "popper-lib.js" # @2.11.8
pin "jquery" # @3.7.1

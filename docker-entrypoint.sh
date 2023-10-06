#!/bin/sh -e

case "$1" in

  web)
    if [[ -z "$SECRET_KEY_BASE" ]] || [[ "$SECRET_KEY_BASE" == "changeme" ]];
    then
      echo "Missing SECRET_KEY_BASE variable."
      echo "Generate a unique and strong value with: openssl rand -hex 64"
      echo ""

      exit 1
    fi

    exec bundle exec puma -C config/puma.rb
  ;;

  *)
    exec "$@"
  ;;

esac

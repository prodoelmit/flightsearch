#!/bin/sh
cd "$(dirname "$0")"
export RAILS_ENV=production
export GEM_HOME="$(pwd)/vendor"

if [ ! "$1" = "--without-install" ]; then

    #try gcc
    if [ -z $(which gcc) ]; then
            echo "gcc is not found, please make sure it's installed and in PATH"
            error="GCC_NOT_FOUND"
    fi

    #try make
    if [ -z $(which make) ]; then
            echo "make is not found, please make sure it's installed and in PATH"
            error="MAKE_NOT_FOUND"
    fi

    if [ -z $(which bundle) ]; then
        echo "bundle is not found, please make sure it's installed and in PATH"
        error="BUNDLE_NOT_FOUND"
    fi


    if [ -n "$error" ]; then
            exit 1
    fi

    bundle install --path vendor/bundle --without development test
fi

export SECRET_KEY_BASE=$(bundle exec rake secret)
bundle exec rake assets:precompile
bundle exec rails server






#!/bin/sh
cd "$(dirname "$0")"
export GEM_HOME="$(pwd)/vendor"
bundler=$(gem install bundler --no-ri --no-rdoc | grep -o "bundler-[0-9\.]\+")
echo $bundler
./vendor/gems/$bundler/exe/bundle install --path vendor/bundle --without development test
rails server -p 3000






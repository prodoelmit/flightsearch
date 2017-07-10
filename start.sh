#!/bin/sh

bundle install vendor/bundle --no-ri --no-rdoc
rspec 
rails server -p 3000






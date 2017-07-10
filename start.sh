#!/bin/sh
cd "$(dirname "$0")"


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


if [ -n "$error" ]; then
	exit 1
fi



export GEM_HOME="$(pwd)/vendor"
export RAILS_ENV=production
bundler=$(gem install bundler --no-ri --no-rdoc | grep -o "bundler-[0-9\.]\+")
echo $bundler
./vendor/gems/$bundler/exe/bundle install --path vendor/bundle --without development test
export SECRET_KEY_BASE=$(bundle exec rake secret)
bundle exec rake assets:precompile
bundle exec rails server






.PHONY: all
default: all;

clean:
	rm -rf .bundle
	rm -rf vendor
	rm -rf Gemfile.lock
	rm -rf Berksfile.lock

install:
	gem install bundler

bundle:
	bundle check --path=vendor/bundle || bundle install --path=vendor/bundle --retry=3

kitchen:
	bundle exec kitchen test

style:
	bundle exec cookstyle -D

all: bundle kitchen

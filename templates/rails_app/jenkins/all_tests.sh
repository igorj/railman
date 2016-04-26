#!/bin/bash
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

rm -rf test/coverage
rm -rf test/screenshots
rm -rf test/reports
cp -f .env.example.test .env
bundle install
RAILS_ENV=test rake db:test:prepare
RAILS_ENV=test HEADLESS=true COVERAGE=true bundle exec rake test

#!/bin/bash
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

bundle install
gem install brakeman
brakeman -o brakeman-output.tabs

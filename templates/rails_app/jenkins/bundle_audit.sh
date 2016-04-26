#!/bin/bash
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

bundle install
gem install bundler-audit
bundle-audit update
bundle-audit check

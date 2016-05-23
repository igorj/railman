# Railman

[![Gem Version](http://img.shields.io/gem/v/railman.svg)][gem]
[![Build Status](http://img.shields.io/travis/igorj/railman.svg)][travis]
[![Dependency Status](http://img.shields.io/gemnasium/igorj/railman.svg)][gemnasium]
[![Code Climate](http://img.shields.io/codeclimate/github/igorj/railman.svg)][codeclimate]
[![Coverage Status](http://img.shields.io/coveralls/igorj/railman.svg)][coveralls]

[gem]: https://rubygems.org/gems/railman
[travis]: http://travis-ci.org/igorj/railman
[gemnasium]: https://gemnasium.com/igorj/railman
[codeclimate]: https://codeclimate.com/github/igorj/railman
[coveralls]: https://coveralls.io/r/igorj/railman

Railman generates new rails applications based on a customized template and ready for deployment in production. 
It can also update existing applications when railman-template changes.
 
The generated rails application includes: 
- semantic-rails-ui gem with modified scaffolds, 
- .env configuration
- deployment configuration, 
- sidekiq background jobs and scheduled jobs
- jenkins scripts
- test infrastructure for capybara headless webtests


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'railman'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install railman


## Usage

Run `railman new APP_NAME` to create new rails application.
Run `railman upgrade APP_NAME` to upgrade existing rails application.


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. 

To release a new version, run `bundle exec rake release_patch`, `bundle exec rake release_minor`, oder `bundle exec rake release_major`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to https://rubygems.org.


## Contributing

Bug reports and pull requests are welcome on github at https://github.com/igorj/railman.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

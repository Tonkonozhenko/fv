# Fv [![Build Status](https://travis-ci.org/Tonkonozhenko/fv.svg?branch=master)](https://travis-ci.org/Tonkonozhenko/fv)

Fv is gem for fast operations with version numbers

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'fv'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install fv

## Usage

Comparing versions became as easy as never. It takes only `4 chars` more than comparing strings.

```ruby

require 'fv/all'
#=> true

v1 = '1.12.0'
#=> "1.12.0"
v2 = '1.2.0'
#=> "1.2.0"

v1 > v2
#=> false
Fv(v1) > v2
#=> true


```

## Development

After checking out the repo, run `bundle install` to install dependencies. Then, run `rake spec` to run the tests.

To install this gem onto your local machine, run `bundle exec rake install`. 

<!-- Comment for releasing: -->
<!-- To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org). -->

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/tonkonozhenko/fv.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).


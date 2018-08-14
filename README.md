# Place RubyGem

A RubyGem for interfacing with the Place API

## Installation

To install using [Bundler](https://bundler.io):

```ruby
gem 'place-ruby', '~> 0.5.5'
```

To install `place-ruby` from github use gem:

```bash
gem install place-ruby
```


## Basic usage

```ruby
require 'place'

# set your api key
Place.api_key = 'private_key_6fsMi3GDxXg1XXSluNx1sLEd'

# create an account
account = Place::Account.create(
    :email => 'joe.schmoe@example.com',
    :full_name => 'Joe Schmoe',
    :user_type => 'payer'
)
```

## Documentation
Read the [docs](https://developer.placepay.com/?ruby)

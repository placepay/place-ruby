# Place RubyGem

A RubyGem for interfacing with the Place API

## Installation

To install using [Bundler](https://bundler.io):

```ruby
gem 'place', :git => 'git://github.com/placepay/place-ruby.git'
```

To manually install `place-ruby` from github use gem specific_install:

```bash
gem install specific_install
gem specific_install https://github.com/placepay/place-ruby.git
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

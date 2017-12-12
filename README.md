# RentShare Ruby Gem

A RubyGem for interfacing with the RentShare API

## Installation

To install using [Bundler][bundler]:

```ruby
gem 'rentshare', :git => 'git://github.com/rentshare/rentshare-ruby.git'
```

To manually install `rentshare-ruby` simply gem install:

```bash
gem specific_install https://github.com/rentshare/rentshare-ruby.git
```


## Basic usage

```ruby
require 'rentshare'

# set your api key
RentShare.api_key = "private_key_6fsMi3GDxXg1XXSluNx1sLEd"

# create an account
account = RentShare::Account.create(
    :email => 'joe.schmoe@example.com',
    :full_name => 'Joe Schmoe',
    :user_type => 'payer'
)
```

## Documentation
Read the [docs][https://developer.rentshare.com/?ruby]
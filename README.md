## Description

NewRelic instrumentation for [riak-ruby-client](https://github.com/basho/riak-ruby-client), [ripple](https://github.com/basho/ripple), and [ripple-encryption](https://github.com/basho/ripple-encryption).

## Dependencies
`newrelic-riak` requires:
- Ruby 1.9.3 or later (1.9.3 was the only version that was tested against)
- [newrelic](https://github.com/newrelic/rpm)
- [riak-ruby-client](https://github.com/basho/riak-ruby-client)

While the following are optional:
- [ripple](https://github.com/basho/ripple)
- [ripple-encryption](https://github.com/basho/ripple-encryption)

## Installation

Add the gem file reference to the Gemfile:

``` ruby
gem 'newrelic_riak', '~> 0.0.2', git: 'git://github.com/basho/newrelic-riak.git'
```

## Usage
Just require the gem where you need it:
``` ruby
require 'newrelic_riak'
```


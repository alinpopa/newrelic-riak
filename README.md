## Description

NewRelic instrumentation for [riak-ruby-client](https://github.com/basho/riak-ruby-client) and [ripple](https://github.com/seancribbs/ripple).

## Dependencies
`newrelic-riak` requires:
- Ruby 1.9.2 or later
- [newrelic](https://github.com/newrelic/rpm)
- [riak-ruby-client](https://github.com/basho/riak-ruby-client)
- [ripple](https://github.com/seancribbs/ripple)

## Installation

Add the gem file reference to the Gemfile:

``` ruby
gem 'newrelic_riak', '~> 0.1.0', git: 'git://github.com/alinpopa/newrelic-riak.git', ref: '7b0bcaadfd5d10daa74825249f484c85f3be488c'
```

## Usage
Just require the gem where you need it:
``` ruby
require 'newrelic_riak'
```


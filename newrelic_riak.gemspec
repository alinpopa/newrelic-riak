Gem::Specification.new do |gem|
  gem.name = "newrelic_riak"
  gem.version = "0.0.2"
  gem.authors = ["Alin Popa","Randy Secrist"]
  gem.date = "2012-10-24"
  gem.description = "NewRelic instrumentation for Riak."
  gem.email = ["alin.popa@gmail.com"]
  gem.homepage = "https://github.com/alinpopa/newrelic-riak"
  gem.summary = "NewRelic instrumentation for Riak."
  
  gem.add_runtime_dependency(%q<newrelic_rpm>, ["~> 3.0"])
  
  gem.files = ["README.txt", "lib/newrelic_riak.rb", "lib/newrelic_riak/riak_client.rb", "lib/newrelic_riak/ripple.rb", "lib/newrelic_riak/ripple_encryption.rb", "newrelic_riak.gemspec"]
  gem.require_paths = ['lib']
end


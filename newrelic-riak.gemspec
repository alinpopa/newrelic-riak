Gem::Specification.new do |s|
  s.name = "newrelic-riak"
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Alin Popa"]
  s.date = "2012-04-23"
  s.description = "NewRelic instrumentation for Riak."
  s.email = ["alin.popa@gmail.com"]
  s.extra_rdoc_files = ["README.txt"]
  s.files = ["README.txt", "Rakefile", "lib/newrelic-riak.rb", "lib/newrelic_riak/riak_client.rb", "lib/newrelic_riak/ripple.rb", "newrelic-riak.gemspec", "test/test_newrelic_riak.rb"]
  s.homepage = "https://github.com/alinpopa/newrelic-riak"
  s.rdoc_options = ["--main", "README.txt"]
  s.require_paths = ["lib"]
  s.rubyforge_project = "newrelic-riak"
  s.rubygems_version = "1.8.17"
  s.summary = "NewRelic instrumentation for Riak."
  #s.test_files = ["test/test_newrelic_riak_client.rb", "test/test_newrelic_ripple.rb"]
  s.add_runtime_dependency(%q<newrelic_rpm>, ["~> 3.0"])
end


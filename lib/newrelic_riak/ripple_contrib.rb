require 'new_relic/agent/method_tracer'

DependencyDetection.defer do
  @name = :ripple_contrib

  depends_on do
    defined?(::Ripple::Encryption) and not NewRelic::Control.instance['disable_ripple_contrib']
  end

  executes do
    NewRelic::Agent.logger.debug 'Installing Ripple Contrib instrumentation'
  end

  executes do
    ::Ripple::Contrib::Serializer.class_eval do
      add_method_tracer :dump, 'Database/Riak/RippleContrib/dump'
      add_method_tracer :load, 'Database/Riak/RippleContrib/load'
    end

    ::Ripple::Contrib::Encryptor.class_eval do
      add_method_tracer :encrypt, 'Database/Riak/RippleContrib/encrypt'
      add_method_tracer :decrypt, 'Database/Riak/RippleContrib/decrypt'
    end
  end
end

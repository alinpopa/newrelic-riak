require 'new_relic/agent/method_tracer'

DependencyDetection.defer do
  @name = :ripple_contrib

  depends_on do
    defined?(::Ripple::Contrib) and not NewRelic::Control.instance['disable_ripple_contrib']
  end

  executes do
    NewRelic::Agent.logger.debug 'Installing Ripple Contrib instrumentation'
  end

  executes do
    ::Ripple::Contrib::EncryptedSerializer.class_eval do
      add_method_tracer :dump, 'Database/Riak_Ripple_Contri/dump'
      add_method_tracer :load, 'Database/Riak_Ripple_Contrib/load'
    end

    ::Ripple::Contrib::Encryptor.class_eval do
      add_method_tracer :encrypt, 'Database/Riak_Ripple_Contrib/encrypt'
      add_method_tracer :decrypt, 'Database/Riak_Ripple_Contrib/decrypt'
    end
  end
end

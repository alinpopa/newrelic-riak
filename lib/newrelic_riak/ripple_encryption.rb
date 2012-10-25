require 'new_relic/agent/method_tracer'

DependencyDetection.defer do
  @name = :ripple_encryption

  depends_on do
    defined?(::Ripple::Encryption) and not NewRelic::Control.instance['disable_ripple_encryption']
  end

  executes do
    NewRelic::Agent.logger.debug 'Installing Ripple Encryption instrumentation'
  end

  executes do
    ::Ripple::Encryption::Serializer.class_eval do
      add_method_tracer :dump, 'Database/Riak_Ripple_Encryption/dump'
      add_method_tracer :load, 'Database/Riak_Ripple_Encryption/load'
    end

    ::Ripple::Encryption::Encryptor.class_eval do
      add_method_tracer :encrypt, 'Database/Riak_Ripple_Encryption/encrypt'
      add_method_tracer :decrypt, 'Database/Riak_Ripple_Encryption/decrypt'
    end
  end
end

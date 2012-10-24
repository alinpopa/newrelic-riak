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
      add_method_tracer :dump, 'Database/Riak/RippleEncryption/dump'
      add_method_tracer :load, 'Database/Riak/RippleEncryption/load'
    end

    ::Ripple::Encryption::Encryptor.class_eval do
      add_method_tracer :encrypt, 'Database/Riak/RippleEncryption/encrypt'
      add_method_tracer :decrypt, 'Database/Riak/RippleEncryption/decrypt'
    end
  end
end

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
    backend_tracers = proc do
    end

    ::Ripple::Encryption::Serializer.class_eval &backend_tracers
    ::Ripple::Encryption::Serializer.class_eval do
      add_method_tracer :dump, 'Database/RippleEncryption/dump'
      add_method_tracer :load, 'Database/RippleEncryption/load'
    end

    ::Ripple::Encryption::Encryptor.class_eval &backend_tracers
    ::Ripple::Encryption::Encryptor.class_eval do
      add_method_tracer :encrypt, 'Database/RippleEncryption/encrypt'
      add_method_tracer :decrypt, 'Database/RippleEncryption/decrypt'
    end
  end
end

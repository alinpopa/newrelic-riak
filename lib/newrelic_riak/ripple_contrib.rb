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
    backend_tracers = proc do
    end

    ::Ripple::Contrib::EncryptedSerializer.class_eval &backend_tracers
    ::Ripple::Contrib::EncryptedSerializer.class_eval do
      add_method_tracer :dump, 'Database/RippleContrib/dump'
      add_method_tracer :load, 'Database/RippleContrib/load'
    end

    ::Ripple::Contrib::Encryptor.class_eval &backend_tracers
    ::Ripple::Contrib::Encryptor.class_eval do
      add_method_tracer :encrypt, 'Database/RippleContrib/encrypt'
      add_method_tracer :decrypt, 'Database/RippleContrib/decrypt'
    end
  end
end

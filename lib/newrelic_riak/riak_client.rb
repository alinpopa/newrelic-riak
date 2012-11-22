require 'new_relic/agent/method_tracer'

DependencyDetection.defer do
  @name = :riak_client

  depends_on do
    defined?(::Riak) and not NewRelic::Control.instance['disable_riak_client']
  end

  executes do
    NewRelic::Agent.logger.debug 'Installing Riak client instrumentation'
  end

  executes do
    backend_tracers = proc do
      add_method_tracer :ping, 'Database/Riak/ping'

      add_method_tracer :list_buckets, 'Database/Riak/list_buckets'
      add_method_tracer :get_bucket_props, 'Database/Riak/get_bucket_props'
      add_method_tracer :set_bucket_props, 'Database/Riak/set_bucket_props'

      add_method_tracer :mapred, 'Database/Riak/mapred'

      add_method_tracer :list_keys, 'Database/Riak/list_keys'
      add_method_tracer :reload_object, 'Database/Riak/reload_object'
      add_method_tracer :delete_object, 'Database/Riak/delete_object'
    end

    ::Riak::Client.class_eval do

      def store_object_with_newrelic_trace(*args, &blk)
        if NewRelic::Agent::Instrumentation::MetricFrame.recording_web_transaction?
          total_metric = 'ActiveRecord/allWeb'
        else
          total_metric = 'ActiveRecord/allOther'
        end

        robject = args[0].is_a?(Array) ? args[0][0] : args[0]
        bucket = robject.respond_to?(:bucket) && robject.bucket ? robject.bucket.name : ''
        bucket = self.newrelic_riak_camelize(bucket)
        metrics = ["ActiveRecord/#{bucket}/save", total_metric, 'ActiveRecord/#{bucket}', 'ActiveRecord/save', 'ActiveRecord/all']

        self.class.trace_execution_scoped(metrics) do
          start = Time.now

          begin
            store_object_without_newrelic_trace(*args, &blk)
          ensure
            s = NewRelic::Agent.instance.transaction_sampler
            s.notice_nosql(args.inspect, (Time.now - start).to_f) rescue nil
          end
        end
      end

      def get_object_with_newrelic_trace(*args, &blk)
        if NewRelic::Agent::Instrumentation::MetricFrame.recording_web_transaction?
          total_metric = 'ActiveRecord/allWeb'
        else
          total_metric = 'ActiveRecord/allOther'
        end

        bucket = args[0].is_a?(Array) ? args[0][0] : args[0]
        bucket = bucket && bucket.respond_to?(:name) ? bucket.name : bucket.to_s
        bucket = self.newrelic_riak_camelize(bucket)
        metrics = ["ActiveRecord/#{bucket}/find", total_metric, 'ActiveRecord/#{bucket}', 'ActiveRecord/find', 'ActiveRecord/all']

        self.class.trace_execution_scoped(metrics) do
          start = Time.now

          begin
            get_object_without_newrelic_trace(*args, &blk)
          ensure
            s = NewRelic::Agent.instance.transaction_sampler
            s.notice_nosql(args.inspect, (Time.now - start).to_f) rescue nil
          end
        end
      end

      alias_method :store_object_without_newrelic_trace, :store_object
      alias_method :store_object, :store_object_with_newrelic_trace
      alias_method :get_object_without_newrelic_trace, :get_object
      alias_method :get_object, :get_object_with_newrelic_trace

      # turn bucket-name-for-things_that_ar-ok into BucketNameForThingsThatArOk
      def newrelic_riak_camelize(term)
        string = term.to_s.capitalize
        string.gsub(/[_-]([a-z]*)/) { "#{$1.capitalize}" }
      end
    end

    ::Riak::Client::BeefcakeProtobuffsBackend.class_eval &backend_tracers
    ::Riak::Client::BeefcakeProtobuffsBackend.class_eval do
      add_method_tracer :server_info, 'Database/Riak/server_info'
      add_method_tracer :get_client_id, 'Database/Riak/get_client_id'
      add_method_tracer :set_client_id, 'Database/Riak/set_client_id'
    end
    ::Riak::Client::HTTPBackend.class_eval &backend_tracers
    ::Riak::Client::HTTPBackend.class_eval do
      add_method_tracer :stats, 'Database/Riak/stats'
      add_method_tracer :link_walk, 'Database/Riak/link_walk'
      add_method_tracer :get_index, 'Database/Riak/get_index'
      add_method_tracer :search, 'Database/Riak/search'
      add_method_tracer :update_search_index, 'Database/Riak/update_search_index'
    end

    ::Riak::RObject.class_eval do
      add_method_tracer :serialize, 'Database/Riak/serialize'
    end
  end
end

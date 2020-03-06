require_relative '../resource'

module Genome
  module DSL
    module Resources
      class RedisElastiCacheParameterGroup
        include DSL::Resource

        resource :redis_elasti_cache_parameter_group

        def template
          {}
        end
      end
    end
  end
end

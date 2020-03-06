require_relative '../resource'

module Genome
  module DSL
    module Resources
      class RedisElastiCacheSubnetGroup
        include DSL::Resource

        resource :redis_elasti_cache_subnet_group

        def template
          {}
        end
      end
    end
  end
end

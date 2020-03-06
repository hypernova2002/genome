require_relative 'redis_elasti_cache_parameter_group'
require_relative 'redis_elasti_cache_subnet_group'

require_relative '../resource'

module Genome
  module DSL
    module Resources
      class RedisElastiCache
        include DSL::Resource

        resource :redis_elasti_cache

        subresource :redis_elasti_cache_parameter_group
        subresource :redis_elasti_cache_subnet_group

        attr_reader :number_of_subnets, :availability_zones
        attr_reader :elasti_cache_cluster_name

        def cluster_name(cluster_name)
          @elasti_cache_cluster_name = cluster_name
        end

        def subnets(num: nil, availability_zones: nil)
          @number_of_subnets = num
          @availability_zones = availability_zones
        end

        def template
          props = resource_properties.dup

          props[:ReplicationGroupDescription] ||= elasti_cache_cluster_name

          templates = {}


          templates.merge!(get_redis_elasti_cache_parameter_group.template) if get_redis_elasti_cache_parameter_group
          templates.merge!(get_redis_elasti_cache_subnet_group.template) if get_redis_elasti_cache_subnet_group

          templates.merge!(props)
        end
      end
    end
  end
end

require 'active_support/concern'

require_relative 'resource'

module Genome
  module DSL
    module Engine
      extend ActiveSupport::Concern

      included do
        Resource.resources.each do |resource_name, resource_klass|
          instance_eval %Q[def get_#{resource_name}; @get_#{resource_name}; end]

          instance_eval %Q[
            def #{resource_name}(resource_name, &blk)
              resource_instance = #{resource_klass}.new

              resource_instance.instance_eval(&blk)

              @get_#{resource_name} = resource_instance
            end
          ]
        end
      end

      module ClassMethods
        def template
          get_redis_elasti_cache.template
        end
      end
    end
  end
end

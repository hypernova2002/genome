require 'active_support'
require 'active_support/concern'
require 'active_support/core_ext'

module Genome
  module DSL
    module Resource
      extend ActiveSupport::Concern

      mattr_accessor :resources, default: {}

      included do
        class_attribute :resource_properties, default: {}
      end

      def properties(params)
        @resource_properties = params
      end

      module ClassMethods
        def resource(resource_name)
          Resource.resources[resource_name] = self
        end

        def subresource(resource_name)
          class_eval %Q[def get_#{resource_name}; @get_#{resource_name}; end]

          class_eval %Q[
            def #{resource_name}(resource_name, &blk)
              resource_klass = Genome::DSL::Resource.resources[:#{resource_name}]

              resource_instance = resource_klass.new

              resource_instance.instance_eval(&blk)

              @get_#{resource_name} = resource_instance
            end
          ]
        end
      end
    end
  end
end

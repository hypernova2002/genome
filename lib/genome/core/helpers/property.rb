require 'active_support'
require 'active_support/concern'
require 'active_support/core_ext'

require_relative 'property_config'
require_relative '../../error'

module Genome
  module Core
    module Helpers
      module Property
        extend ActiveSupport::Concern

        included do
          class_attribute :property_configs, default: {}
        end

        module ClassMethods
          def property(property_name, property_options = {})
            raise Error::DuplicateProperty, "Property already defined '#{property_name}'" if self.property_configs.key?(property_name)

            property_configs[property_name] = PropertyConfig.new(property_options)
          end

          def valid_property?(property_name, property_value)
            property_configs[property_name].valid?(property_value)
          end
        end
      end
    end
  end
end

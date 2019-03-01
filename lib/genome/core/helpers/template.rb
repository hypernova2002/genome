require 'active_support/concern'

module Genome
  module Core
    module Helpers
      module Template
        extend ActiveSupport::Concern

        attr_reader :template_name, :parameters, :dependencies

        def initialize(template_name, template_parameters, dependencies)
          @template_name = template_name
          @parameters = {}
          @dependencies = dependencies || []

          template_parameters.each do |parameter_name, parameter_value|
            if property_configs.key?(parameter_name)
              @parameters[parameter_name] = parameter_value
            end
          end
        end

        def to_h
          {
            template_name => {
              Type: self.class.aws_template,
              Properties: parameters,
              DependsOn: dependencies
            }
          }
        end

        module ClassMethods
          def aws_template(aws_template_value = nil)
            if aws_template_value
              @aws_template = aws_template_value
            else
              @aws_template
            end
          end
        end
      end
    end
  end
end

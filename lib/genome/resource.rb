require 'active_support'
require 'active_support/concern'
require 'active_support/core_ext'

require_relative 'error'
require_relative 'parameter'
require_relative 'reference'

module Genome
  module Resource
    extend ActiveSupport::Concern

    included do
      class_attribute :templates, default: {}
      class_attribute :parameters, default: {}
      class_attribute :references, default: []
      class_attribute :description
    end

    module ClassMethods
      def template(template_name, template_klass, template_properties)
        raise Error::DuplicateTemplate, "Duplicate template name defined '#{template_name}'" if templates.key?(template_name)

        dependencies = template_properties.delete(:DependsOn)

        templates[template_name] = {
          klass: template_klass,
          properties: template_properties,
          dependencies: dependencies,
        }
      end

      def remove_template(template_name)
        templates.delete(template_name)
        remove_dependencies(template_name)
      end

      def parameter(parameter_name, parameter_options = {})
        raise Error::DuplicateParameter, "Duplicate parameter name defined '#{parameter_name}'" if parameters.key?(parameter_name)

        parameters[parameter_name] = Parameter.new(parameter_name: parameter_name, parameter_options: parameter_options)
      end

      def override_parameter(parameter_name, parameter_options = {})
        raise Error::MissingParameterName, "Parameter name not defined '#{parameter_name}'" unless parameters.key?(parameter_name)

        parameters[parameter_name].parameter_options.merge!(parameter_options)
      end

      def remove_dependencies(*dependencies)
        templates.each do |template_name, template_parameters|
          dependencies.each do |dependency|
            template_parameters[:dependencies]&.delete(dependency)
          end
        end
      end

      def reference(resource_name)
        Reference.new(resource_name)
      end
    end

    # mattr_accessor :resources, default: [], instance_accessor: false

    # included do
    #   Resource.resources << self
    # end
  end
end

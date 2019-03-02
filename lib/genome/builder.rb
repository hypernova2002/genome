require_relative 'config'
require_relative 'resource'

module Genome
  module Builder
    module_function

    def self.template(resource)
      resources = {}

      resource.templates.each do |template_name, template|
        properties = evaluate_properties(template[:properties])

        dependencies = template[:dependencies]

        resource_template = template[:klass].new(template_name, properties, dependencies)

        resources.merge!(resource_template.to_h)
      end

      parameters = {}

      resource.parameters.each do |_parameter_name, parameter|
        parameters.merge!(parameter.to_h)
      end

      generate_document(resources: resources, parameters: parameters, description: resource.resource_description)
    end

    def self.generate_document(metadata: {}, description: nil, resources: {}, parameters: {}, outputs: {})
      {
        AWSTemplateFormatVersion: Config.config[:AWSTemplateFormatVersion],
        Description: [Config::DESCRIPTION_PREFIX, description].compact.join(''),
        Metadata: metadata,
        Resources: resources,
        Parameters: parameters,
        Outputs: outputs
      }
    end

    def self.evaluate_properties(properties)
      # TODO: convert classes and helper functions into appropriate properties
      processed_properties = {}

      properties.each do |properties_name, properties_value|
        processed_properties[properties_name] = evaluate_properties_value(properties_value)
      end

      processed_properties
    end

    def self.evaluate_properties_value(properties_value)
        case properties_value
        when Array
          properties_value.map do |single_properties_value|
            evaluate_properties_value(single_properties_value)
          end
        when Genome::Reference
          { Ref: properties_value.reference_name }
        else
          properties_value
        end
    end

    # def generate_template
    #   resources_config = {}

    #   resources = generate_resources

    #   templates.each do |build_name, config|
    #     params = evaluate_params(config[:params], resources)

    #     resources[build_name].set_properties(params)

    #     resources_config.merge!(resources[build_name].config)
    #   end

    #   {
    #     AWSTemplateFormatVersion: '2010-09-09',
    #     Metadata: {},
    #     Resources: resources_config,
    #     Parameters: generate_parameters,
    #     Outputs: generate_outputs
    #   }
    # end

    # def generate_parameters
    #   Hash[parameters.map do |parameter_name, config|
    #     [parameter_name, config[:klass].new(config[:params]).config]
    #   end]
    # end

    # def generate_resources
    #   Hash[templates.map do |build_name, config|
    #     [build_name, config[:klass].new(build_name)]
    #   end]
    # end

    # def generate_outputs
    #   Hash[outputs.map do |output_name, klass|
    #     [output_name, klass.new.config]
    #   end]
    # end

    # def klass
    # end
  end
end

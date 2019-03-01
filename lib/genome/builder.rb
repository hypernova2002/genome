require_relative 'config'
require_relative 'resource'

module Genome
  module Builder
    module_function

    def self.template(resource)
      resources = {}

      resource.templates.each do |template_name, template|
        parameters = evaluate_parameters(template[:parameters])

        dependencies = template[:dependencies]

        resource_template = template[:klass].new(template_name, parameters, dependencies)

        resources.merge!(resource_template.to_h)
      end

      generate_document(resources: resources, description: resource.description)
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

    def self.evaluate_parameters(parameters)
      # TODO: convert classes and helper functions into appropriate parameters
      processed_parameters = {}

      parameters.each do |parameter_name, parameter_value|
        processed_parameters[parameter_name] = evaluate_parameter_value(parameter_value)
      end

      processed_parameters
    end

    def self.evaluate_parameter_value(parameter_value)
        case parameter_value
        when Array
          parameter_value.map do |single_parameter_value|
            evaluate_parameter_value(single_parameter_value)
          end
        when Genome::Reference
          { Ref: parameter_value.reference_name }
        else
          parameter_value
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

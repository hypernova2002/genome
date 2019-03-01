require_relative 'error'

module Genome
  class Parameter
    PARAMETERS = {
      AllowedPattern: { type: :string },
      AllowedValues: { type: :array },
      ConstraintDescription: { type: :string },
      Default: { type: :any },
      Description: { type: :string },
      MaxLength: { type: :integer },
      MaxValue: { type: :integer },
      MaxValue: { type: :integer },
      MinLength: { type: :integer },
      MinValue: { type: :integer },
      NoEcho: { type: :boolean },
      Type: { type: :string },
      NoEcho: { type: :boolean },
      NoEcho: { type: :boolean },
      NoEcho: { type: :boolean }
    }.freeze

    attr_reader :parameter_name
    attr_accessor :parameter_options

    def initialize(parameter_name:, parameter_options: {})
      validate_parameter_options!(parameter_options)

      @parameter_name    = parameter_name
      @parameter_options = parameter_options
    end

    def validate_parameter_options!(parameter_options)
      parameter_options.each do |parameter_option_name, parameter_option_value|
        parameter_option_rules = PARAMETERS[parameter_option_name]

        raise Error::UnknownParameter, "Unknown parameter '#{parameter_option_name}'" unless parameter_option_rules

        allowed_parameter_type = parameter_option_rules[:type]

        raise Error::InvalidParameterType, "Invalid parameter type #{{
          parameter_value: parameter_value,
          allowed_parameter_type: allowed_parameter_type,
        }}" unless check_parameter_type(parameter_option_value, allowed_parameter_type)
      end
    end

    def check_parameter_type(parameter_value, allowed_parameter_type)
      case allowed_parameter_type
      when :string
        parameter_value.is_a?(String)
      when :integer
        begin
          Integer(parameter_value)

          true
        rescue
          false
        end
      when :boolean
        ['true', 'false'].include?(parameter_value.to_s.downcase)
      when :array
        parameter_value.is_a?(Array)
      when :any
        true
      end
    end

    def to_h
      {
        parameter_name => parameter_options
      }
    end
  end
end

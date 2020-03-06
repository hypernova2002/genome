require 'active_support'
require 'active_support/concern'
require 'active_support/core_ext'
require 'aws-sdk-cloudformation'
require 'json'

require_relative 'builder'
require_relative 'error'

module Genome
  module Stack
    extend ActiveSupport::Concern

    mattr_accessor :stacks, default: {}

    included do
      class_attribute :capabilities, default: [:CAPABILITY_IAM, :CAPABILITY_NAMED_IAM]
      class_attribute :resources, default: []
      class_attribute :parameterised_resources, default: []
      class_attribute :template_url
      class_attribute :disable_rollback
      class_attribute :rollback_configuration
      class_attribute :timeout_in_minutes
      class_attribute :notification_arns
      class_attribute :resource_types
      class_attribute :role_arn
      class_attribute :on_failure
      class_attribute :stack_policy_body
      class_attribute :stack_policy_url
      class_attribute :tags
      class_attribute :client_request_token
      class_attribute :enable_termination_protection
    end


    module ClassMethods
      def stack_name(stack_name)
        @stack_name = stack_name

        Stack.stacks[stack_name] = self
      end

      def capability(capability_name)
        capabilities << capability_name
      end

      def disable_iam_capabilities
        capabilities.delete(:CAPABILITY_IAM)
        capabilities.delete(:CAPABILITY_NAMED_IAM)
      end

      def resource(resource_klass)
        resources << resource_klass
      end

      def parameterised_resource(resource_klass, *params)
        @parameterised_resources << resource_klass.new(params)
      end

      def cloudformation_client
        @cloudformation_client ||= Aws::CloudFormation::Client.new
      end

      def build_parameterised_resource
        parameterised_resources.each do |parameterised_resource|
          if parameterised_resources.access_from
            parameterised_resources.security_groups
          end
        end
      end

      def build
        template = nil

        resources.each do |resource|
          template = Genome::Builder.template(resource)
        end

        cloudformation_client.create_stack(
          stack_name: @stack_name,
          template_body: template.to_json,
          parameters: [],
          capabilities: @capabilities
        )
      end
    end
  end
end


# require 'aws-sdk-cloudformation'
# require 'json'

# module DcLibStack
#   module Generator
#     def self.included(base)
#       base.extend(ClassMethods)
#     end

#     module ClassMethods
#       def cloudformation_client
#         @cloudformation_client ||= Aws::CloudFormation::Client.new
#       end

#       def create(stack_name)
#         template = new.generate_template

#         cloudformation_client.create_stack(
#           stack_name: stack_name,
#           template_body: template.to_json,
#           parameters: [
#             {
#               parameter_key: "BenchmarkName",
#               parameter_value: stack_name
#             }
#           ],
#           capabilities: ['CAPABILITY_IAM', 'CAPABILITY_NAMED_IAM']
#         )
#       end

#       def update(stack_name)
#         template = new.generate_template

#         cloudformation_client.update_stack(
#           stack_name: stack_name,
#           template_body: template.to_json,
#           parameters: [
#             {
#               parameter_key: "BenchmarkName",
#               parameter_value: stack_name
#             }
#           ],
#           capabilities: ['CAPABILITY_IAM', 'CAPABILITY_NAMED_IAM']
#         )
#       end

#       def destroy(stack_name)
#         cloudformation_client.delete_stack(stack_name: stack_name)
#       end
#     end
#   end
# end

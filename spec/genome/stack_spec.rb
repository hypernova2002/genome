require 'spec_helper'

require_relative '../../lib/genome/stack'

RSpec.describe Genome::Stack do
  subject(:test_klass) { Class.new { include Genome::Stack; stack_name :test_stack } }

  it 'adds to list of stacks' do
    test_klass

    expect(Genome::Stack.stacks[:test_stack]).to eq(test_klass)
  end

  context '::capability' do
    it 'has default capabilities' do
      expect(test_klass.capabilities).to include(:CAPABILITY_IAM)
      expect(test_klass.capabilities).to include(:CAPABILITY_NAMED_IAM)
    end

    it 'adds capability' do
      test_klass.capability :new_capability

      expect(test_klass.capabilities).to include(:new_capability)
    end
  end

  context '::disable_iam_capabilities' do
    it 'removes iam capabilities' do
      test_klass.disable_iam_capabilities

      expect(test_klass.capabilities).not_to include(:CAPABILITY_IAM)
      expect(test_klass.capabilities).not_to include(:CAPABILITY_NAMED_IAM)
    end
  end

  context '::resource' do
    it 'adds resource' do
      test_klass.resource String

      expect(test_klass.resources).to eql([String])
    end
  end
end


# def stack_name(stack_name)
#   @stack_name = stack_name

#   Stack.stacks[stack_name] = self
# end

# def capability(capability_name)
#   @capabilities << capability_name
# end

# def disable_iam_capabilities
#   @capabilities.delete(:CAPABILITY_IAM)
#   @capabilities.delete(:CAPABILITY_NAMED_IAM)
# end

# def cloudformation_client
#   @cloudformation_client ||= Aws::CloudFormation::Client.new
# end

# def resource(resource_klass)
#   @resources << resource_klass
# end

# def build
#   template = nil

#   @resources.each do |resource|
#     template << Genome::Builder.template(resource)
#   end

#   cloudformation_client.create_stack(
#     stack_name: @stack_name,
#     template_body: template.to_json,
#     parameters: [],
#     capabilities: @capabilities
#   )
# end
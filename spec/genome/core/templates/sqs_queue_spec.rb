require 'spec_helper'
require_relative '../../../../lib/genome/core/templates/sqs_queue'

RSpec.describe Genome::Core::Templates::SQSQueue do
  subject(:sqs_queue) { Genome::Core::Templates::SQSQueue }

  context '::aws_template' do
    it 'aws_template is set to AWS::SQS::Queue' do
      expect(sqs_queue.aws_template).to eq('AWS::SQS::Queue')
    end
  end

  context '::property_configs' do
    it 'configures VisibilityTimeout property' do
      expect(sqs_queue.property_configs.key?(:VisibilityTimeout)).to be true
    end

    it 'configures QueueName property' do
      expect(sqs_queue.property_configs.key?(:QueueName)).to be true
    end
  end
end

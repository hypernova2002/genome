require_relative 'base'

module Genome
  module Core
    module Templates
      class SQSQueue
        include Base

        aws_template 'AWS::SQS::Queue'

        property :VisibilityTimeout, settable: true
        property :QueueName, settable: true
      end
    end
  end
end

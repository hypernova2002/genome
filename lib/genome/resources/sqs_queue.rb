require_relative '../resource'
require_relative '../core/templates/ec2_security_group'
require_relative '../core/templates/sqs_queue'

module Genome
  module Resources
    class SQSQueue
      include Resource

      template :SQSSecurityGroup, Core::Templates::EC2SecurityGroup,
        GroupDescription: 'Security Group for SQS'

      template :SQSQueue, Core::Templates::SQSQueue,
        QueueName: 'default_queue',
        DependsOn: [ :SQSSecurityGroup ]

    end
  end
end

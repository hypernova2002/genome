require_relative 'base'

module Genome
  module Core
    module Templates
      class EC2SecurityGroupIngress
        include Base

        aws_template 'AWS::EC2::SecurityGroupIngress'

        property :GroupId, settable: true
        property :SourceSecurityGroupId, settable: true
        property :FromPort, settable: true
        property :ToPort, settable: true
        property :IpProtocol, settable: true

        module IpProtocols
          TCP = 'tcp'.freeze
          ICMP = 'icmp'.freeze
        end
      end
    end
  end
end

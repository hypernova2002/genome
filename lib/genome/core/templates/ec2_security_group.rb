require_relative 'base'

module Genome
  module Core
    module Templates
      class EC2SecurityGroup
        include Base

        aws_template 'AWS::EC2::SecurityGroup'

        property :GroupDescription
        property :GroupName
        property :SecurityGroupEgress
        property :SecurityGroupIngress
        property :Tags
        property :VpcId
      end
    end
  end
end

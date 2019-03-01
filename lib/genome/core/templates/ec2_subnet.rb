require_relative 'base'

module Genome
  module Core
    module Templates
      class EC2Subnet
        include Base

        aws_template 'AWS::EC2::Subnet'

        property :AssignIpv6AddressOnCreation
        property :AvailabilityZone
        property :CidrBlock
        property :Ipv6CidrBlock
        property :MapPublicIpOnLaunch
        property :Tags
        property :VpcId
      end
    end
  end
end

require_relative 'base'

module Genome
  module Core
    module Templates
      class EC2VPC
        include Base

        aws_template 'AWS::EC2::VPC'

        property :CidrBlock
        property :EnableDnsSupport
        property :EnableDnsHostnames
        property :CidrBlockInstanceTenancy
        property :Tags

        module InstanceTenancies
          DEFAULT = 'default'.freeze
        end
      end
    end
  end
end

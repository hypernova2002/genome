require_relative 'base'

module Genome
  module Core
    module Templates
      class DocumentDBSubnetGroup
        include Base

        aws_template 'AWS::DocDB::DBSubnetGroup'

        property :DBSubnetGroupDescription
        property :DBSubnetGroupName
        property :SubnetIds
        property :Tags
      end
    end
  end
end

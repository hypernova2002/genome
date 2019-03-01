require_relative 'base'

module Genome
  module Core
    module Templates
      class DocumentDBParameterGroup
        include Base

        aws_template 'AWS::DocDB::DBClusterParameterGroup'

        property :Description
        property :Family
        property :Name
        property :Parameters
        property :Tags
      end
    end
  end
end

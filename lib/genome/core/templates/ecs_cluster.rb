require_relative 'base'

module Genome
  module Core
    module Templates
      class ECSCluster
        include Base

        aws_template 'AWS::ECS::Cluster'
      end
    end
  end
end

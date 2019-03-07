require_relative 'base'

module Genome
  module Core
    module Templates
      class ElastiCacheSubnetGroup
        include Base

        aws_template 'AWS::ElastiCache::SubnetGroup'

        property :CacheSubnetGroupName
        property :Description
        property :SubnetIds
      end
    end
  end
end

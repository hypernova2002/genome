require_relative 'base'

module Genome
  module Core
    module Templates
      class ElastiCacheParameterGroup
        include Base

        aws_template 'AWS::ElastiCache::ParameterGroup'

        property :CacheParameterGroupFamily
        property :Description
        property :Properties
      end
    end
  end
end

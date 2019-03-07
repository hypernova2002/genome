require_relative 'base'

module Genome
  module Core
    module Templates
      class ElastiCacheCluster
        include Base

        aws_template 'AWS::ElastiCache::CacheCluster'

        property :AutoMinorVersionUpgrade
        property :AZMode
        property :CacheNodeType
        property :CacheParameterGroupName
        property :CacheSecurityGroupNames
        property :CacheSubnetGroupName
        property :ClusterName
        property :Engine
        property :EngineVersion
        property :NotificationTopicArn
        property :NumCacheNodes
        property :Port
        property :PreferredAvailabilityZone
        property :PreferredAvailabilityZones
        property :PreferredMaintenanceWindow
        property :SnapshotArns
        property :SnapshotName
        property :SnapshotRetentionLimit
        property :SnapshotWindow
        property :Tags
        property :VpcSecurityGroupIds
      end
    end
  end
end

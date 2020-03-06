require_relative 'base'

module Genome
  module Core
    module Templates
      class ElastiCacheReplicationGroup
        include Base

        DEFAULT_PORT = 6379

        aws_template 'AWS::ElastiCache::ReplicationGroup'

        property :AtRestEncryptionEnabled
        property :AuthToken
        property :AutomaticFailoverEnabled
        property :AutoMinorVersionUpgrade
        property :CacheNodeType
        property :CacheParameterGroupName
        property :CacheSecurityGroupNames
        property :CacheSubnetGroupName
        property :Engine
        property :EngineVersion
        property :NodeGroupConfiguration
        property :NotificationTopicArn
        property :NumCacheClusters
        property :NumNodeGroups
        property :Port
        property :PreferredCacheClusterAZs
        property :PreferredMaintenanceWindow
        property :PrimaryClusterId
        property :ReplicasPerNodeGroup
        property :ReplicationGroupDescription
        property :ReplicationGroupId
        property :SecurityGroupIds
        property :SnapshotArns
        property :SnapshotName
        property :SnapshotRetentionLimit
        property :SnapshottingClusterId
        property :SnapshotWindow
        property :Tags
        property :TransitEncryptionEnabled
      end
    end
  end
end

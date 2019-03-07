require_relative '../resource'
require_relative '../core/templates/elasti_cache_cluster'
require_relative '../core/templates/elasti_cache_parameter_group'
require_relative '../core/templates/elasti_cache_replication_group'
require_relative '../core/templates/elasti_cache_subnet_group'
require_relative '../core/templates/ec2_security_group'
require_relative '../core/templates/ec2_subnet'
require_relative '../core/templates/ec2_vpc'

module Genome
  module Resources
    class RedisElastiCache
      include Resource

      parameter :RedisElastiCacheClusterName,
        Default: 'redis-elastic-cache',
        Description: "The Redis ElastiCache cluster name",
        Type: "String",
        MinLength: "1",
        MaxLength: "20",
        AllowedPattern: "[a-zA-Z][a-zA-Z0-9]*(-[a-zA-Z0-9]+)*",
        ConstraintDescription: "Must begin with a letter and contain only alphanumeric characters."

      parameter :RedisElastiCacheSubnetGroupName,
        Default: 'redis-elasticache-subnet-group',
        Description: "Subnet group name",
        Type: "String",
        MinLength: "1",
        MaxLength: "64",
        AllowedPattern: "[a-zA-Z][a-zA-Z0-9]*(-[a-zA-Z0-9]+)*",
        ConstraintDescription: "Must begin with a letter and contain only alphanumeric characters."

      parameter :RedisElastiCacheParameterGroupName,
        Default: 'redis-elasticache-parameter-group',
        Description: "Parameter group name",
        Type: "String",
        MinLength: "1",
        MaxLength: "64",
        AllowedPattern: "[a-zA-Z][a-zA-Z0-9]*(-[a-zA-Z0-9]+)*",
        ConstraintDescription: "Must begin with a letter and contain only alphanumeric characters."


      template :RedisElastiCacheEC2SVPC, Core::Templates::EC2VPC,
        CidrBlock: '10.51.0.0/16',
        EnableDnsSupport: true,
        InstanceTenancy: Core::Templates::EC2VPC::InstanceTenancies::DEFAULT,
        Tags: [
          { Key: :Resource, Value: :RedisElastiCache }
        ]

      template :RedisElastiCacheEC2SubnetUSEast1A, Core::Templates::EC2Subnet,
        VpcId: reference(:RedisElastiCacheEC2SVPC),
        CidrBlock: '10.51.0.0/24',
        AvailabilityZone: 'us-east-1a',
        Tags: [
          { Key: :Resource, Value: :RedisElastiCache }
        ],
        DependsOn: [
          :RedisElastiCacheEC2SVPC
        ]

      template :RedisElastiCacheEC2SubnetUSEast1B, Core::Templates::EC2Subnet,
        VpcId: reference(:RedisElastiCacheEC2SVPC),
        CidrBlock: '10.51.1.0/24',
        AvailabilityZone: 'us-east-1b',
        Tags: [
          { Key: :Resource, Value: :RedisElastiCache }
        ],
        DependsOn: [
          :RedisElastiCacheEC2SVPC
        ]

      template :RedisElastiCacheSubnetGroup, Core::Templates::ElastiCacheSubnetGroup,
        Description: 'Maintained by Genome: Default Redis ElastiCache Subnet Group',
        CacheSubnetGroupName: reference(:RedisElastiCacheSubnetGroupName),
        SubnetIds: [
          reference(:RedisElastiCacheEC2SubnetUSEast1A),
          reference(:RedisElastiCacheEC2SubnetUSEast1B)
        ],
        DependsOn: [
          :RedisElastiCacheEC2SubnetUSEast1A,
          :RedisElastiCacheEC2SubnetUSEast1B
        ]

      template :RedisElastiCacheParameterGroup, Core::Templates::ElastiCacheParameterGroup,
        Description: 'Maintained by Genome: Default Redis ElastiCache Parameter Group',
        CacheParameterGroupFamily: 'redis5.0'

      template :RedisElastiCacheSecurityGroup, Core::Templates::EC2SecurityGroup,
        VpcId: reference(:RedisElastiCacheEC2SVPC),
        GroupDescription: 'redis-elasti-cache-security-group'

      template :RedisElastiCacheReplicationGroup, Core::Templates::ElastiCacheReplicationGroup,
        AtRestEncryptionEnabled: true,
        AutomaticFailoverEnabled: true,
        CacheNodeType: 'cache.t2.micro',
        CacheParameterGroupName: reference(:RedisElastiCacheParameterGroup),
        CacheSubnetGroupName: reference(:RedisElastiCacheSubnetGroup),
        Engine: :redis,
        EngineVersion: '5.0.3',
        NumCacheClusters: 2,
        ReplicationGroupDescription: reference(:RedisElastiCacheClusterName),
        SecurityGroupIds: [
          reference(:RedisElastiCacheSecurityGroup)
        ],
        SnapshotRetentionLimit: 1,
        Tags: [
          { Key: :Resource, Value: :RedisElastiCache }
        ],
        DependsOn: [
          :RedisElastiCacheSubnetGroup,
          :RedisElastiCacheParameterGroup,
          :RedisElastiCacheSecurityGroup
        ]

      def self.disable_vpc
        remove_template(:RedisElastiCacheEC2SVPC)
        remove_dependencies(:RedisElastiCacheEC2SVPC)
      end

      def self.disable_subnets
        remove_template(:RedisElastiCacheEC2SubnetUSEast1A)
        remove_template(:RedisElastiCacheEC2SubnetUSEast1B)
      end

      def self.subnet_ids(subnet_ids)
        templates[:RedisElastiCacheSubnetGroup][:properties].merge!(
          SubnetIds: subnet_ids
        )
      end

      def self.security_group_ids(security_group_ids)
        templates[:RedisElastiCacheReplicationGroup][:properties].merge!(
          SecurityGroupIds: security_group_ids
        )
      end

      def self.add_cluster_dependencies(*dependencies)
        cluster_dependencies = templates[:RedisElastiCacheReplicationGroup][:properties][:DependsOn] || []
        cluster_dependencies += dependencies

        templates[:RedisElastiCacheReplicationGroup][:properties][:DependsOn] = cluster_dependencies
      end
    end
  end
end

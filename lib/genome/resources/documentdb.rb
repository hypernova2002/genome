require_relative '../resource'
require_relative '../core/templates/documentdb_cluster'
require_relative '../core/templates/documentdb_instance'
require_relative '../core/templates/documentdb_parameter_group'
require_relative '../core/templates/documentdb_subnet_group'
require_relative '../core/templates/ec2_subnet'
require_relative '../core/templates/ec2_vpc'

module Genome
  module Resources
    class DocumentDB
      include Resource

      template :DocumentDBEC2SVPC, Core::Templates::EC2VPC,
        CidrBlock: '10.50.0.0/16',
        EnableDnsSupport: true,
        InstanceTenancy: Core::Templates::EC2VPC::InstanceTenancies::DEFAULT,
        Tags: [
          { Key: :Resource, Value: :DocumentDBCluster }
        ]

      template :DocumentDBEC2SubnetUSEast1A, Core::Templates::EC2Subnet,
        VpcId: reference(:DocumentDBEC2SVPC),
        CidrBlock: '10.50.0.0/24',
        AvailabilityZone: 'us-east-1a',
        Tags: [
          { Key: :Resource, Value: :DocumentDBCluster }
        ],
        DependsOn: [
          :DocumentDBEC2SVPC
        ]

      template :DocumentDBEC2SubnetUSEast1B, Core::Templates::EC2Subnet,
        VpcId: reference(:DocumentDBEC2SVPC),
        CidrBlock: '10.50.1.0/24',
        AvailabilityZone: 'us-east-1b',
        Tags: [
          { Key: :Resource, Value: :DocumentDBCluster }
        ],
        DependsOn: [
          :DocumentDBEC2SVPC
        ]

      template :DocumentDBEC2SubnetUSEast1C, Core::Templates::EC2Subnet,
        VpcId: reference(:DocumentDBEC2SVPC),
        CidrBlock: '10.50.2.0/24',
        AvailabilityZone: 'us-east-1c',
        Tags: [
          { Key: :Resource, Value: :DocumentDBCluster }
        ],
        DependsOn: [
          :DocumentDBEC2SVPC
        ]

      template :DocumentDBSubnetGroup, Core::Templates::DocumentDBSubnetGroup,
        DBSubnetGroupDescription: 'Maintained by Genome: Default DocumentDB Subnet Group',
        DBSubnetGroupName: 'documentdb-cluster',
        SubnetIds: [
          reference(:DocumentDBEC2SubnetUSEast1A),
          reference(:DocumentDBEC2SubnetUSEast1B),
          reference(:DocumentDBEC2SubnetUSEast1C),
        ],
        Tags: [
          { Key: :Resource, Value: :DocumentDBCluster }
        ],
        DependsOn: [
          :DocumentDBEC2SubnetUSEast1A,
          :DocumentDBEC2SubnetUSEast1B,
          :DocumentDBEC2SubnetUSEast1C
        ]

      template :DocumentDBInstance, Core::Templates::DocumentDBInstance,
        AutoMinorVersionUpgrade: true,
        DBClusterIdentifier: 'documentdb-cluster',
        DBInstanceClass: :'db.r4.large',
        DBInstanceIdentifier: 'documentdb-instance',
        Tags: [
          { Key: :Resource, Value: :DocumentDBCluster }
        ],
        DependsOn: [
          :DocumentDBCluster
        ]

      template :DocumentDBParameterGroup, Core::Templates::DocumentDBParameterGroup,
        Description: 'Maintained by Genome: Default DocumentDB Parameter Group',
        Family: 'docdb3.6',
        Name: 'documentdb-parameter-group',
        Parameters: {
          audit_logs: :enabled,
          tls: :enabled,
          ttl_monitor: :enabled
        },
        Tags: [
          { Key: :Resource, Value: :DocumentDBCluster }
        ]

      template :DocumentDBCluster, Core::Templates::DocumentDBCluster,
        DBClusterIdentifier: 'documentdb-cluster',
        DBClusterParameterGroupName: 'documentdb-parameter-group',
        DBSubnetGroupName: 'documentdb-cluster',
        MasterUsername: 'master',
        MasterUserPassword: 'anotverysecurepassword9876',
        StorageEncrypted: true,
        Tags: [
          { Key: :Resource, Value: :DocumentDBCluster }
        ],
        DependsOn: [
          :DocumentDBParameterGroup,
          :DocumentDBSubnetGroup
        ]

      def self.disable_vpc
        remove_template(:DocumentDBEC2SVPC)
        remove_dependencies(:DocumentDBEC2SVPC)
      end

      def self.disable_subnets
        remove_template(:DocumentDBEC2SubnetUSEast1A)
        remove_template(:DocumentDBEC2SubnetUSEast1B)
        remove_template(:DocumentDBEC2SubnetUSEast1C)
      end

      def self.subnet_ids(subnet_ids)
        templates[:DocumentDBSubnetGroup][:parameters][:SubnetIds] = subnet_ids
      end

      def self.security_group_ids(security_group_ids)
        templates[:DocumentDBCluster][:parameters][:VpcSecurityGroupIds] = security_group_ids
      end

      def self.add_cluster_dependencies(*dependencies)
        cluster_dependencies = templates[:DocumentDBCluster][:parameters][:DependsOn] || []
        cluster_dependencies += dependencies

        templates[:DocumentDBCluster][:parameters][:DependsOn] = cluster_dependencies
      end
    end
  end
end

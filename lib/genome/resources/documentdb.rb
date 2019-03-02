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

      parameter :DocumentDBMasterUsername,
        Default: 'master',
        NoEcho: "true",
        Description: "The database admin account username",
        Type: "String",
        MinLength: "1",
        MaxLength: "16",
        AllowedPattern: "[a-zA-Z][a-zA-Z0-9]*",
        ConstraintDescription: "Must begin with a letter and contain only alphanumeric characters."

      parameter :DocumentDBMasterPassword,
        Default: 'anotverysecurepassword9876',
        NoEcho: "true",
        Description: "The database admin account password",
        Type: "String",
        MinLength: "1",
        MaxLength: "41",
        AllowedPattern: "[a-zA-Z0-9]+",
        ConstraintDescription: "Must contain only alphanumeric characters."

      parameter :DocumentDBSubnetGroupName,
        Default: 'documentdb-subnet-group',
        Description: "Subnet group name",
        Type: "String",
        MinLength: "1",
        MaxLength: "64",
        AllowedPattern: "[a-zA-Z][a-zA-Z0-9]*(-[a-zA-Z0-9]+)*",
        ConstraintDescription: "Must begin with a letter and contain only alphanumeric characters."

      parameter :DocumentDBParameterGroupName,
        Default: 'documentdb-parameter-group',
        Description: "Parameter group name",
        Type: "String",
        MinLength: "1",
        MaxLength: "64",
        AllowedPattern: "[a-zA-Z][a-zA-Z0-9]*(-[a-zA-Z0-9]+)*",
        ConstraintDescription: "Must begin with a letter and contain only alphanumeric characters."

      parameter :DocumentDBClusterIdentifier,
        Default: 'documentdb-cluster',
        Description: "Cluster identifier",
        Type: "String",
        MinLength: "1",
        MaxLength: "64",
        AllowedPattern: "[a-zA-Z][a-zA-Z0-9]*(-[a-zA-Z0-9]+)*",
        ConstraintDescription: "Must begin with a letter and contain only alphanumeric characters."

      parameter :DocumentDBInstanceIdentifier,
        Default: 'documentdb-instance',
        Description: "Instance identifier",
        Type: "String",
        MinLength: "1",
        MaxLength: "64",
        AllowedPattern: "[a-zA-Z][a-zA-Z0-9]*(-[a-zA-Z0-9]+)*",
        ConstraintDescription: "Must begin with a letter and contain only alphanumeric characters."

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
        DBSubnetGroupName: reference(:DocumentDBSubnetGroupName),
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
        DBClusterIdentifier: reference(:DocumentDBClusterIdentifier),
        DBInstanceClass: :'db.r4.large',
        DBInstanceIdentifier: reference(:DocumentDBInstanceIdentifier),
        Tags: [
          { Key: :Resource, Value: :DocumentDBCluster }
        ],
        DependsOn: [
          :DocumentDBCluster
        ]

      template :DocumentDBParameterGroup, Core::Templates::DocumentDBParameterGroup,
        Description: 'Maintained by Genome: Default DocumentDB Parameter Group',
        Family: 'docdb3.6',
        Name: reference(:DocumentDBParameterGroupName),
        Parameters: {
          audit_logs: :enabled,
          tls: :enabled,
          ttl_monitor: :enabled
        },
        Tags: [
          { Key: :Resource, Value: :DocumentDBCluster }
        ]

      template :DocumentDBCluster, Core::Templates::DocumentDBCluster,
        DBClusterIdentifier: reference(:DocumentDBClusterIdentifier),
        DBClusterParameterGroupName: reference(:DocumentDBParameterGroupName),
        DBSubnetGroupName: reference(:DocumentDBSubnetGroupName),
        MasterUsername: reference(:DocumentDBMasterUsername),
        MasterUserPassword: reference(:DocumentDBMasterPassword),
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

      def self.disable_tls
        templates[:DocumentDBParameterGroup][:properties][:Parameters].merge!(
          tls: :disabled
        )
      end

      def self.subnet_ids(subnet_ids)
        templates[:DocumentDBSubnetGroup][:properties].merge!(
          SubnetIds: subnet_ids
        )
      end

      def self.security_group_ids(security_group_ids)
        templates[:DocumentDBCluster][:properties].merge!(
          VpcSecurityGroupIds: security_group_ids
        )
      end

      def self.add_cluster_dependencies(*dependencies)
        cluster_dependencies = templates[:DocumentDBCluster][:properties][:DependsOn] || []
        cluster_dependencies += dependencies

        templates[:DocumentDBCluster][:properties][:DependsOn] = cluster_dependencies
      end
    end
  end
end

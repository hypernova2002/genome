require_relative 'base'

module Genome
  module Core
    module Templates
      class DocumentDBCluster
        include Base

        aws_template 'AWS::DocDB::DBCluster'

        property :AvailabilityZones
        property :BackupRetentionPeriod
        property :DBClusterIdentifier
        property :DBClusterParameterGroupName
        property :DBSubnetGroupName
        property :EngineVersion
        property :KmsKeyId
        property :MasterUsername
        property :MasterUserPassword
        property :Port
        property :PreferredBackupWindow
        property :PreferredMaintenanceWindow
        property :SnapshotIdentifier
        property :StorageEncrypted
        property :Tags
        property :VpcSecurityGroupIds
      end
    end
  end
end

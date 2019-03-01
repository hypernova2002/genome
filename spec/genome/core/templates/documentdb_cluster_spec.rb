require 'spec_helper'
require_relative '../../../../lib/genome/core/templates/documentdb_cluster'

RSpec.describe Genome::Core::Templates::DocumentDBCluster do
  subject(:documentdb_cluster) { Genome::Core::Templates::DocumentDBCluster }

  context '::aws_template' do
    it 'aws_template is set to AWS::DocDB::DBCluster' do
      expect(documentdb_cluster.aws_template).to eq('AWS::DocDB::DBCluster')
    end
  end

  context '::property_configs' do
    it 'configures AvailabilityZones property' do
      expect(documentdb_cluster.property_configs.key?(:AvailabilityZones)).to be true
    end

    it 'configures BackupRetentionPeriod property' do
      expect(documentdb_cluster.property_configs.key?(:BackupRetentionPeriod)).to be true
    end

    it 'configures DBClusterIdentifier property' do
      expect(documentdb_cluster.property_configs.key?(:DBClusterIdentifier)).to be true
    end

    it 'configures DBClusterParameterGroupName property' do
      expect(documentdb_cluster.property_configs.key?(:DBClusterParameterGroupName)).to be true
    end

    it 'configures DBSubnetGroupName property' do
      expect(documentdb_cluster.property_configs.key?(:DBSubnetGroupName)).to be true
    end

    it 'configures EngineVersion property' do
      expect(documentdb_cluster.property_configs.key?(:EngineVersion)).to be true
    end

    it 'configures KmsKeyId property' do
      expect(documentdb_cluster.property_configs.key?(:KmsKeyId)).to be true
    end

    it 'configures MasterUsername property' do
      expect(documentdb_cluster.property_configs.key?(:MasterUsername)).to be true
    end

    it 'configures MasterUserPassword property' do
      expect(documentdb_cluster.property_configs.key?(:MasterUserPassword)).to be true
    end

    it 'configures Port property' do
      expect(documentdb_cluster.property_configs.key?(:Port)).to be true
    end

    it 'configures PreferredBackupWindow property' do
      expect(documentdb_cluster.property_configs.key?(:PreferredBackupWindow)).to be true
    end

    it 'configures PreferredMaintenanceWindow property' do
      expect(documentdb_cluster.property_configs.key?(:PreferredMaintenanceWindow)).to be true
    end

    it 'configures SnapshotIdentifier property' do
      expect(documentdb_cluster.property_configs.key?(:SnapshotIdentifier)).to be true
    end

    it 'configures StorageEncrypted property' do
      expect(documentdb_cluster.property_configs.key?(:StorageEncrypted)).to be true
    end

    it 'configures Tags property' do
      expect(documentdb_cluster.property_configs.key?(:Tags)).to be true
    end

    it 'configures VpcSecurityGroupIds property' do
      expect(documentdb_cluster.property_configs.key?(:VpcSecurityGroupIds)).to be true
    end
  end
end

require 'spec_helper'
require_relative '../../../../lib/genome/core/templates/elasti_cache_cluster'

RSpec.describe Genome::Core::Templates::ElastiCacheCluster do
  subject(:elasti_cache_cluster) { Genome::Core::Templates::ElastiCacheCluster }

  context '::aws_template' do
    it 'aws_template is set to AWS::ElastiCache::CacheCluster' do
      expect(elasti_cache_cluster.aws_template).to eq('AWS::ElastiCache::CacheCluster')
    end
  end

  context '::property_configs' do
    it 'configures AutoMinorVersionUpgrade property' do
      expect(elasti_cache_cluster.property_configs.key?(:AutoMinorVersionUpgrade)).to be true
    end

    it 'configures AZMode property' do
      expect(elasti_cache_cluster.property_configs.key?(:AZMode)).to be true
    end

    it 'configures CacheNodeType property' do
      expect(elasti_cache_cluster.property_configs.key?(:CacheNodeType)).to be true
    end

    it 'configures CacheParameterGroupName property' do
      expect(elasti_cache_cluster.property_configs.key?(:CacheParameterGroupName)).to be true
    end

    it 'configures CacheSecurityGroupNames property' do
      expect(elasti_cache_cluster.property_configs.key?(:CacheSecurityGroupNames)).to be true
    end

    it 'configures CacheSubnetGroupName property' do
      expect(elasti_cache_cluster.property_configs.key?(:CacheSubnetGroupName)).to be true
    end

    it 'configures ClusterName property' do
      expect(elasti_cache_cluster.property_configs.key?(:ClusterName)).to be true
    end

    it 'configures Engine property' do
      expect(elasti_cache_cluster.property_configs.key?(:Engine)).to be true
    end

    it 'configures EngineVersion property' do
      expect(elasti_cache_cluster.property_configs.key?(:EngineVersion)).to be true
    end

    it 'configures NotificationTopicArn property' do
      expect(elasti_cache_cluster.property_configs.key?(:NotificationTopicArn)).to be true
    end

    it 'configures NumCacheNodes property' do
      expect(elasti_cache_cluster.property_configs.key?(:NumCacheNodes)).to be true
    end

    it 'configures Port property' do
      expect(elasti_cache_cluster.property_configs.key?(:Port)).to be true
    end

    it 'configures PreferredAvailabilityZone property' do
      expect(elasti_cache_cluster.property_configs.key?(:PreferredAvailabilityZone)).to be true
    end

    it 'configures PreferredAvailabilityZones property' do
      expect(elasti_cache_cluster.property_configs.key?(:PreferredAvailabilityZones)).to be true
    end

    it 'configures PreferredMaintenanceWindow property' do
      expect(elasti_cache_cluster.property_configs.key?(:PreferredMaintenanceWindow)).to be true
    end

    it 'configures SnapshotArns property' do
      expect(elasti_cache_cluster.property_configs.key?(:SnapshotArns)).to be true
    end

    it 'configures SnapshotName property' do
      expect(elasti_cache_cluster.property_configs.key?(:SnapshotName)).to be true
    end

    it 'configures SnapshotRetentionLimit property' do
      expect(elasti_cache_cluster.property_configs.key?(:SnapshotRetentionLimit)).to be true
    end

    it 'configures SnapshotWindow property' do
      expect(elasti_cache_cluster.property_configs.key?(:SnapshotWindow)).to be true
    end

    it 'configures Tags property' do
      expect(elasti_cache_cluster.property_configs.key?(:Tags)).to be true
    end

    it 'configures VpcSecurityGroupIds property' do
      expect(elasti_cache_cluster.property_configs.key?(:VpcSecurityGroupIds)).to be true
    end
  end
end

require 'spec_helper'
require_relative '../../../../lib/genome/core/templates/documentdb_instance'

RSpec.describe Genome::Core::Templates::DocumentDBInstance do
  subject(:documentdb_instance) { Genome::Core::Templates::DocumentDBInstance }

  context '::aws_template' do
    it 'aws_template is set to AWS::DocDB::DBInstance' do
      expect(documentdb_instance.aws_template).to eq('AWS::DocDB::DBInstance')
    end
  end

  context '::property_configs' do
    it 'configures AutoMinorVersionUpgrade property' do
      expect(documentdb_instance.property_configs.key?(:AutoMinorVersionUpgrade)).to be true
    end

    it 'configures AvailabilityZone property' do
      expect(documentdb_instance.property_configs.key?(:AvailabilityZone)).to be true
    end

    it 'configures DBClusterIdentifier property' do
      expect(documentdb_instance.property_configs.key?(:DBClusterIdentifier)).to be true
    end

    it 'configures DBInstanceClass property' do
      expect(documentdb_instance.property_configs.key?(:DBInstanceClass)).to be true
    end

    it 'configures DBInstanceIdentifier property' do
      expect(documentdb_instance.property_configs.key?(:DBInstanceIdentifier)).to be true
    end

    it 'configures PreferredMaintenanceWindow property' do
      expect(documentdb_instance.property_configs.key?(:PreferredMaintenanceWindow)).to be true
    end

    it 'configures Tags property' do
      expect(documentdb_instance.property_configs.key?(:Tags)).to be true
    end
  end
end

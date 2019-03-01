require 'spec_helper'
require_relative '../../../../lib/genome/core/templates/documentdb_subnet_group'

RSpec.describe Genome::Core::Templates::DocumentDBSubnetGroup do
  subject(:documentdb_subnet_group) { Genome::Core::Templates::DocumentDBSubnetGroup }

  context '::aws_template' do
    it 'aws_template is set to AWS::DocDB::DBSubnetGroup' do
      expect(documentdb_subnet_group.aws_template).to eq('AWS::DocDB::DBSubnetGroup')
    end
  end

  context '::property_configs' do
    it 'configures DBSubnetGroupDescription property' do
      expect(documentdb_subnet_group.property_configs.key?(:DBSubnetGroupDescription)).to be true
    end

    it 'configures DBSubnetGroupName property' do
      expect(documentdb_subnet_group.property_configs.key?(:DBSubnetGroupName)).to be true
    end

    it 'configures SubnetIds property' do
      expect(documentdb_subnet_group.property_configs.key?(:SubnetIds)).to be true
    end

    it 'configures Tags property' do
      expect(documentdb_subnet_group.property_configs.key?(:Tags)).to be true
    end
  end
end

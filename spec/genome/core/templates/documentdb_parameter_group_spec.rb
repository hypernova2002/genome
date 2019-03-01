require 'spec_helper'
require_relative '../../../../lib/genome/core/templates/documentdb_parameter_group'

RSpec.describe Genome::Core::Templates::DocumentDBParameterGroup do
  subject(:documentdb_parameter_group) { Genome::Core::Templates::DocumentDBParameterGroup }

  context '::aws_template' do
    it 'aws_template is set to AWS::DocDB::DBClusterParameterGroup' do
      expect(documentdb_parameter_group.aws_template).to eq('AWS::DocDB::DBClusterParameterGroup')
    end
  end

  context '::property_configs' do
    it 'configures Description property' do
      expect(documentdb_parameter_group.property_configs.key?(:Description)).to be true
    end

    it 'configures Family property' do
      expect(documentdb_parameter_group.property_configs.key?(:Family)).to be true
    end

    it 'configures Name property' do
      expect(documentdb_parameter_group.property_configs.key?(:Name)).to be true
    end

    it 'configures Parameters property' do
      expect(documentdb_parameter_group.property_configs.key?(:Parameters)).to be true
    end

    it 'configures Tags property' do
      expect(documentdb_parameter_group.property_configs.key?(:Tags)).to be true
    end
  end
end

require 'spec_helper'
require_relative '../../../../lib/genome/core/helpers/property'

RSpec.describe Genome::Core::Helpers::Property do
  subject(:test_klass) { Class.new { include Genome::Core::Helpers::Property } }

  let(:property_name) { :test_property }
  let(:property_parameters) {
    {
      param1: 'value_1', param2: 'value_2'
    }
  }

  context '::property_configs' do
    it 'sets a property' do
      test_klass.property property_name

      expect(test_klass.property_configs.key?(property_name)).to be true
    end

    it 'sets a property with attributes' do
      test_klass.property property_name, property_parameters

      expect(test_klass.property_configs[property_name].to_h).to eq(Genome::Core::Helpers::PropertyConfig.new(property_parameters).to_h)
    end

    it 'raises Genome::Error::DuplicateProperty for duplicate property name' do
      test_klass.property property_name

      expect { test_klass.property property_name }.to raise_error(Genome::Error::DuplicateProperty)
    end
  end
end

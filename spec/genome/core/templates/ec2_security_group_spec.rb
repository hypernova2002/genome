require 'spec_helper'
require_relative '../../../../lib/genome/core/templates/ec2_security_group'

RSpec.describe Genome::Core::Templates::EC2SecurityGroup do
  subject(:ec2_security_group) { Genome::Core::Templates::EC2SecurityGroup }

  context '::aws_template' do
    it 'aws_template is set to AWS::EC2::SecurityGroup' do
      expect(ec2_security_group.aws_template).to eq('AWS::EC2::SecurityGroup')
    end
  end

  context '::property_configs' do
    it 'configures GroupDescription property' do
      expect(ec2_security_group.property_configs.key?(:GroupDescription)).to be true
    end

    it 'configures GroupName property' do
      expect(ec2_security_group.property_configs.key?(:GroupName)).to be true
    end

    it 'configures SecurityGroupEgress property' do
      expect(ec2_security_group.property_configs.key?(:SecurityGroupEgress)).to be true
    end

    it 'configures SecurityGroupIngress property' do
      expect(ec2_security_group.property_configs.key?(:SecurityGroupIngress)).to be true
    end

    it 'configures Tags property' do
      expect(ec2_security_group.property_configs.key?(:Tags)).to be true
    end

    it 'configures VpcId property' do
      expect(ec2_security_group.property_configs.key?(:VpcId)).to be true
    end
  end
end

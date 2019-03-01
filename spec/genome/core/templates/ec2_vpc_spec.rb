require 'spec_helper'
require_relative '../../../../lib/genome/core/templates/ec2_vpc'

RSpec.describe Genome::Core::Templates::EC2VPC do
  subject(:ec2_vpc) { Genome::Core::Templates::EC2VPC }

  context '::aws_template' do
    it 'aws_template is set to AWS::EC2::VPC' do
      expect(ec2_vpc.aws_template).to eq('AWS::EC2::VPC')
    end
  end

  context '::property_configs' do
    it 'configures CidrBlock property' do
      expect(ec2_vpc.property_configs.key?(:CidrBlock)).to be true
    end

    it 'configures EnableDnsSupport property' do
      expect(ec2_vpc.property_configs.key?(:EnableDnsSupport)).to be true
    end

    it 'configures EnableDnsHostnames property' do
      expect(ec2_vpc.property_configs.key?(:EnableDnsHostnames)).to be true
    end

    it 'configures CidrBlockInstanceTenancy property' do
      expect(ec2_vpc.property_configs.key?(:CidrBlockInstanceTenancy)).to be true
    end

    it 'configures Tags property' do
      expect(ec2_vpc.property_configs.key?(:Tags)).to be true
    end
  end
end

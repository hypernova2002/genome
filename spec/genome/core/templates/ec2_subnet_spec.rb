require 'spec_helper'
require_relative '../../../../lib/genome/core/templates/ec2_subnet'

RSpec.describe Genome::Core::Templates::EC2Subnet do
  subject(:ec2_subnet) { Genome::Core::Templates::EC2Subnet }

  context '::aws_template' do
    it 'aws_template is set to AWS::EC2::Subnet' do
      expect(ec2_subnet.aws_template).to eq('AWS::EC2::Subnet')
    end
  end

  context '::property_configs' do
    it 'configures AssignIpv6AddressOnCreation property' do
      expect(ec2_subnet.property_configs.key?(:AssignIpv6AddressOnCreation)).to be true
    end

    it 'configures AvailabilityZone property' do
      expect(ec2_subnet.property_configs.key?(:AvailabilityZone)).to be true
    end

    it 'configures CidrBlock property' do
      expect(ec2_subnet.property_configs.key?(:CidrBlock)).to be true
    end

    it 'configures Ipv6CidrBlock property' do
      expect(ec2_subnet.property_configs.key?(:Ipv6CidrBlock)).to be true
    end

    it 'configures MapPublicIpOnLaunch property' do
      expect(ec2_subnet.property_configs.key?(:MapPublicIpOnLaunch)).to be true
    end

    it 'configures Tags property' do
      expect(ec2_subnet.property_configs.key?(:Tags)).to be true
    end

    it 'configures VpcId property' do
      expect(ec2_subnet.property_configs.key?(:VpcId)).to be true
    end
  end
end

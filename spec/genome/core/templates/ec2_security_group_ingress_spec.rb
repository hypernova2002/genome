require 'spec_helper'
require_relative '../../../../lib/genome/core/templates/ec2_security_group_ingress'

RSpec.describe Genome::Core::Templates::EC2SecurityGroupIngress do
  subject(:ec2_security_group_ingress) { Genome::Core::Templates::EC2SecurityGroupIngress }

  context '::aws_template' do
    it 'aws_template is set to AWS::EC2::SecurityGroupIngress' do
      expect(ec2_security_group_ingress.aws_template).to eq('AWS::EC2::SecurityGroupIngress')
    end
  end

  context '::property_configs' do
    it 'configures GroupId property' do
      expect(ec2_security_group_ingress.property_configs.key?(:GroupId)).to be true
    end

    it 'configures SourceSecurityGroupId property' do
      expect(ec2_security_group_ingress.property_configs.key?(:SourceSecurityGroupId)).to be true
    end

    it 'configures FromPort property' do
      expect(ec2_security_group_ingress.property_configs.key?(:FromPort)).to be true
    end

    it 'configures ToPort property' do
      expect(ec2_security_group_ingress.property_configs.key?(:ToPort)).to be true
    end

    it 'configures IpProtocol property' do
      expect(ec2_security_group_ingress.property_configs.key?(:IpProtocol)).to be true
    end
  end

  context '::IpProtocols' do
    it 'TCP returns tcp' do
      expect(Genome::Core::Templates::EC2SecurityGroupIngress::IpProtocols::TCP).to eql('tcp')
    end

    it 'ICMP returns icmp' do
      expect(Genome::Core::Templates::EC2SecurityGroupIngress::IpProtocols::ICMP).to eql('icmp')
    end
  end
end

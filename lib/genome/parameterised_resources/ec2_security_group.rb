require_relative '../coe/templates/ec2_security_group'

module Genome
  module ParameterisedResources
    class Ec2SecurityGroup
      attr_reader :dependencies
      attr_reader :properties
      attr_reader :resource_name

      attr_accessor :is_vpc_disabled

      AccessRule = Struct.new(:FromPort, :ToPort, :IpProtocol, :SourceSecurityGroupId)

      def initialize(resource_name, params = {})
        @dependencies = []
        @is_vpc_disabled = false
        @properties = {}
        @resource_name = resource_name

        update_params!(params)
      end

      def update_params!(params = {})
        @is_vpc_disabled = params[:is_vpc_disabled] if params.key?(:is_vpc_disabled)

        @dependencies.concat(params[:dependencies]) if params.key?(:dependencies)

        update_properties!(params) if params[:properties]
      end

      def update_properties!(params = {})
        egress_rules = params[:properties].delete(:SecurityGroupEgress)
        ingress_rules = params[:properties].delete(:SecurityGroupIngress)

        add_egress_rules(egress_rules) if egress_rules
        add_ingress_rules(ingress_rules) if ingress_rules

        @properties.merge!(params[:properties])
      end

      def add_tags(tags)
        @properties[:Tags].concat(tags)
      end

      def add_egress_rules(rules)
        add_access_rules(:SecurityGroupEgress, rules)
      end

      def add_ingress_rules(rules)
        add_access_rules(:SecurityGroupIngress, rules)
      end

      def add_access_rules(access_name, rules)
        @properties[access_name] ||= []

        rules.each do |rule|
          rule[:FromPort] ||= rule[:Port]
          rule[:ToPort] ||= rule[:Port]

          rule.delete(:Port)

          @properties[access_name] << AccessRule.new(rule).to_h
        end
      end

      def template
        processed_properties = process_properties(properties)

        Core::Templates::EC2SecurityGroup.new(resource_name, processed_properties, dependencies).to_h
      end

      private

      def process_properties(properties)
        processed_properties = properties.dup
        processed_properties.delete(:VpcId) if is_vpc_disabled
        processed_properties
      end
    end
  end
end

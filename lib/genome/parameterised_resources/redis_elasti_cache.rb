require 'securerandom'

require_relative '../coe/templates/ec2_security_group'

module Genome
  module ParameterisedResources
    class RedisElastiCache
      attr_reader :dependencies
      attr_reader :properties
      attr_reader :resource_name

      attr_accessor :is_vpc_disabled

      attr_accessor :parameter_group
      attr_accessor :replication_group
      attr_accessor :security_groups
      attr_accessor :subnet_group
      attr_accessor :subnets
      attr_accessor :vpc

      AccessRule = Struct.new(IpProtocol:, :SourceSecurityGroupId, :Port = 6379)

      def initialize(resource_name, params = {})
        @dependencies = []
        @is_vpc_disabled = false
        @resource_name = resource_name
        @properties = default_properties

        update_params!(params)
      end

      def update_params!(params = {})
        @is_vpc_disabled = params[:is_vpc_disabled] if params.key?(:is_vpc_disabled)

        @vpc

        @dependencies.concat(params[:dependencies]) if params.key?(:dependencies)

        update_parameter_group!(params[:parameter_group]) if params[:parameter_group]
        update_replication_group!(params[:replication_group]) if params[:replication_group]
        update_subnet_group!(params[:subnet_group]) if params[:subnet_group]
        update_vpc!(params[:vpc]) if params[:vpc]

        add_security_group(params[:security_groups]) if params[:security_groups]
        add_subnets(params[:subnets]) if params[:subnets]
      end

      def update_parameter_group!(params = {})
        parameter_group.merge!(params)
      end

      def update_replication_group!(params = {})
        replication_group.merge!(params)
      end

      def update_subnet_group!(params = {})
        subnet_group.merge!(params)
      end

      def update_vpc!(params = {})
        vpc.merge!(params)
      end

      def add_security_group(params = {})
        security_groups << ParameterisedResources::Ec2SecurityGroup.new(params)
      end

      def add_subnets(params = {})
        subnets << params
      end

      def add_tags(tags)
        @properties[:Tags].concat(tags)
      end

      def access_from(rules)
        rules.each do |rule|
          rule[:Port] ||= Core::Templates::ElastiCacheReplicationGroup::DEFAULT_PORT

          if rule[:via]
            security_group = security_groups.find { |group| group.resource_name == rule[:via] }

            rule.delete(:via)

            security_group.update(rule)
          else
            rule[:resource_name] ||= SecureRandom.hex(8)

            add_security_group(rule)
          end
        end
      end

      def template
        Core::Templates::ElastiCacheReplicationGroup.new(resource_name, properties, dependencies).to_h
      end

      def default_properties
        {
          AtRestEncryptionEnabled: true,
          AutomaticFailoverEnabled: true,
          CacheNodeType: 'cache.t2.micro',
          Engine: :redis,
          EngineVersion: '5.0.3',
          NumCacheClusters: 2,
          ReplicationGroupDescription: resource_name,
          SnapshotRetentionLimit: 1
        }
      end
    end
  end
end

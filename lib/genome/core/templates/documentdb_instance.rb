require_relative 'base'

module Genome
  module Core
    module Templates
      class DocumentDBInstance
        include Base

        aws_template 'AWS::DocDB::DBInstance'

        property :AutoMinorVersionUpgrade
        property :AvailabilityZone
        property :DBClusterIdentifier
        property :DBInstanceClass
        property :DBInstanceIdentifier
        property :PreferredMaintenanceWindow
        property :Tags
      end
    end
  end
end

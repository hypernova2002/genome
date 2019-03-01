module Genome
  module Core
    module Helpers
      class PropertyConfig
        attr_reader :settable, :nullable

        def initialize(options = {})
          @settable = options[:settable]
          @nullable = options[:nullable]
        end


        def valid?(property_value)
          return false if !nullable && property_value == nil

          true
        end

        def to_h
          {
            settable: settable,
            nullable: nullable
          }
        end

        alias :settable? :settable
        alias :nullable? :nullable
      end
    end
  end
end

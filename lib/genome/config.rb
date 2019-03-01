module Genome
  module Config
    module_function

    DESCRIPTION_PREFIX = 'Maintained by Genome: '.freeze

    def self.config
      @@configuration ||= default_config
    end

    def self.configure
      @@configuration ||= default_config

      yield @@configuration if block_given?

      @@configuration
    end

    def self.default_config
      {
        AWSTemplateFormatVersion: '2010-09-09'
      }
    end
  end
end

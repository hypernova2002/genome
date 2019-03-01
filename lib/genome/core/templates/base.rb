require 'active_support/concern'

require_relative '../helpers/template'
require_relative '../helpers/property'

module Genome
  module Core
    module Templates
      module Base
        extend ActiveSupport::Concern

        included do
          include Helpers::Property
          include Helpers::Template
        end
      end
    end
  end
end

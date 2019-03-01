module Genome
  class Reference
    attr_reader :reference_name

    def initialize(reference_name)
      @reference_name = reference_name
    end
  end
end

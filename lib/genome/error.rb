module Genome
  module Error
    class Base < StandardError; end

    class DuplicateProperty < Base; end

    class DuplicateTemplate < Base; end

    class DuplicateParameter < Base; end

    class MissingParameterName < Base; end

    class UnknownParameter < Base; end

    class InvalidParameterType < Base; end
  end
end

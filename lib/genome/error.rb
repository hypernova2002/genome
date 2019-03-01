module Genome
  module Error
    class Base < StandardError; end

    class DuplicateProperty < Base; end

    class DuplicateTemplate < Base; end
  end
end

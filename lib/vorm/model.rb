module Vorm
  class Model
    class << self
      def table(name = nil)
        raise(ArgumentError, "Table name must be a string") if name && !name.is_a?(String)
        @table ||= name
      end
    end
  end
end


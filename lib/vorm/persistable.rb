module Vorm
  module Persistable
    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      def table(name = nil)
        raise(ArgumentError, "Table name must be a string") if name && !name.is_a?(String)
        @table ||= name
      end

      def field(name)
        raise(ArgumentError, "Field name must be a string") if name && !name.is_a?(String)
        @fields ? @fields.add(name) : @fields = Set.new([name])
      end

      def fields
        @fields
      end
    end
  end
end


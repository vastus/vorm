module Vorm
  module Validatable
    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      def validates(field, &validator)
        raise(ArgumentError, "Field name must be a string") if field && !field.is_a?(String)
        raise(ArgumentError, "You must provide a block") if !block_given?
        _add_validator(field, validator)
      end

    private

      def _add_validator(field, validator)
        @validators ||= Hash.new { |k, v| k[v] = [] }
        @validators[field] << validator
      end
    end
  end
end


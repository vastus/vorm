require 'vorm/validatable/validation_error'

module Vorm
  module Validatable
    def valid?
      validate!
      errors.empty?
    end

    def validate!(field = nil)
      field ? _validate_field!(field) : _validate_fields!
    end

    def errors
      ValidationError.instance
    end

    private

    def _validate_field!(field)
      _validators[field].each do |validator|
        value = send(field)
        message = value.nil? ? validator.call(value) : nil # check explicitly for nil? b/c we want to be able to validate for truthey/falsey
        errors.add(field, message) unless message.nil? # no validation errors
      end
    end

    def _validate_fields!
      _validators.each_key do |field|
        _validate_field!(field)
      end if _validators
    end

    def _validators
      self.class.instance_variable_get("@validators")
    end

    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      def validates(field, &validator)
        raise(ArgumentError, "Field name must be a string") if field && !field.is_a?(String)
        raise(ArgumentError, "You must provide a block") if !block_given?
        _add_validator(field, validator)
        attr_accessor(field)
      end

      private

      def _add_validator(field, validator)
        @validators ||= Hash.new { |k, v| k[v] = [] }
        @validators[field] << validator
      end
    end
  end
end


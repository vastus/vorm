module Vorm
  module Validatable
    class ValidationError
      private_class_method(:new)

      def initialize
        @errors = Hash.new { |k, v| k[v] = [] }
      end

      def add(field, message)
        @errors[field] << message
      end

      def on(field)
        @errors[field]
      end

      def empty?
        @errors.keys.empty?
      end

      def self.instance
        @@instance ||= new
      end
    end
  end
end


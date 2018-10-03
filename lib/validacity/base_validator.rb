module Validacity
  class BaseValidator
    include ::ActiveModel::Validations

    class << self
      def inherited(klass)
        Validacity.validators[validator_name(klass)] = klass
      end

      private

      def validator_name(klass)
        klass.name.gsub(/Validator$/, "").underscore.to_sym
      end
    end

    def initialize(resource)
      @resource = resource
    end

    def respond_to?(name)
      @resource.respond_to?(method)
    end

    def respond_to_missing?
      true
    end

    def method_missing(name, *attrs, &block)
      @resource.public_send(name, *attrs, &block)
    end

    def validate
      return true if valid?

      errors.each do |field, error|
        @resource.errors[field] << error
      end

      false
    end

    def validate!
      validate or raise ActiveModel::ValidationError, @resource
    end
  end
end

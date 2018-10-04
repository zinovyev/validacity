module Validacity
  class BaseValidation
    include ::ActiveModel::Validations

    class << self
      def inherited(klass)
        Validacity.validations[validation_name(klass)] = klass
      end

      private

      def validation_name(klass)
        klass.name.gsub(/Validation$/, "").underscore.to_sym
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

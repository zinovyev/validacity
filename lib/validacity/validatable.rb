module Validacity
  module Validatable
    extend ActiveSupport::Concern

    class_methods do
      def validations(*names)
        names.each { |n| validacity_validators << n }
      end

      def validacity_validators
        @_validacity_validators ||= Set.new
      end

      def new(resource)
        instance = super
        instance.validacity_validators.merge(validacity_validators.dup)
        instance
      end
    end

    def validacity_validators
      @_validacity_validators ||= Set.new
    end

    def valid?(context = nil)
      super
      validacity_validators_run(context)
      errors.empty?
    end

    private

    def validacity_validators_run(_context = nil)
      each_validator_instance(&:validate)
    end

    def each_validator_instance
      @_validacity_validators_instances ||= {}
      validacity_validators.each do |name|
        unless (validator = @_validacity_validators_instances[name])
          validator = Validacity.find_validator(name).new(self)
          @_validacity_validators_instances[name] = validator
        end
        yield(validator)
      end
    end
  end
end

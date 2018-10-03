module Validacity
  module Validatable
    extend ActiveSupport::Concern

    def valid?
      super
      validacity_validators_run
      errors.empty?
    end

    def validacity_validators_run
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

    def validacity_validators
      @_validacity_validators ||= Set.new
    end
  end
end

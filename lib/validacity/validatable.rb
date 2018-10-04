module Validacity
  module Validatable
    extend ActiveSupport::Concern

    class_methods do
      def validations(*names)
        names.each { |n| validacity_validations << n }
        validacity_validations
      end

      def validacity_validations
        @_validacity_validations ||= Set.new
      end

      def new(resource)
        instance = super
        instance.validacity_validations.merge(validacity_validations.dup)
        instance
      end
    end

    def validations(*names)
      names.each { |n| validacity_validations << n }
      validacity_validations
    end

    def validacity_validations
      @_validacity_validations ||= Set.new
    end

    def valid?(context = nil)
      super
      validacity_validations_run(context)
      errors.empty?
    end

    private

    def validacity_validations_run(_context = nil)
      each_validation_instance(&:validate)
    end

    def each_validation_instance
      @_validacity_validations_instances ||= {}
      validacity_validations.each do |name|
        unless (validation = @_validacity_validations_instances[name])
          validation = Validacity.find_validation(name).new(self)
          @_validacity_validations_instances[name] = validation
        end
        yield(validation)
      end
    end
  end
end

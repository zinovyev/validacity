require "active_support"
require "active_model"

require "validacity/version"
require "validacity/configuration"
require "validacity/base_validation"
require "validacity/validatable"

module Validacity
  class << self
    def configuration
      @configuration ||= Validacity::Configuration.new
    end

    def configure
      yield configuration if block_given?
    end

    def validations
      @_validations ||= {}
    end

    def find_validation(name)
      validation = validations[name]
      return validation if validation

      reload_validations
      validations[name]
    end

    private

    def reload_validations
      Dir.glob(configuration.search_paths) do |validation|
        send(require_method, validation)
      end
    end

    def require_method
      @_require_method ||= if Kernel.respond_to?(:require_dependency)
                             :require_dependency
                           else
                             :require
                           end
    end
  end
end

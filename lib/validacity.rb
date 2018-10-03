require "active_support"
require "active_model"

require "validacity/version"
require "validacity/configuration"
require "validacity/base_validator"
require "validacity/validatable"

module Validacity
  class << self
    def configuration
      @configuration ||= Validacity::Configuration.new
    end

    def configure
      yield configuration if block_given?
    end

    def validators
      @_validators ||= {}
    end

    def find_validator(name)
      validator = validators[name]
      return validator if validator

      reload_validators
      validators[name]
    end

    private

    def reload_validators
      Dir.glob(configuration.search_paths) do |validator|
        send(require_method, validator)
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

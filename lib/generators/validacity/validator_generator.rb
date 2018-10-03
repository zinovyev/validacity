module Validacity
  module Generators
    class ValidatorGenerator < ::Rails::Generators::NamedBase
      source_root File.expand_path("templates", __dir__)

      def create_validator
        validator_file = File.join("app/validators", class_path,
                                   "#{file_name}_validator.rb")
        template "validator.rb", validator_file
      end
    end
  end
end

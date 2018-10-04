module Validacity
  module Generators
    class ValidationGenerator < ::Rails::Generators::NamedBase
      source_root File.expand_path("templates", __dir__)

      def create_validation
        validation_file = File.join("app/validations", class_path,
                                   "#{file_name}_validation.rb")
        template "validation.rb", validation_file
      end
    end
  end
end

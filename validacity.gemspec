$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "validacity/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "validacity"
  s.version     = Validacity::VERSION
  s.authors     = ["Ivan Zinovyev"]
  s.email       = ["vanyazin@gmail.com"]
  s.homepage    = "https://github.com/zinovyev/validacity"
  s.summary     = "Validation objects for Rails"
  s.description = <<-DESCR.gsub(/    /, "")
    Validacity adds an extra layer of validation objects where all \
    your validation logic can be moved to.
  DESCR
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.0"
  s.add_dependency "activemodel", "~> 5.0"
  s.add_dependency "activesupport", "~> 5.0"

  s.add_development_dependency "pry"
  s.add_development_dependency "rake"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "rubocop"
end

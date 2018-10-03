module Validacity
  class Configuration
    attr_reader :options

    def initialize
      @options = {}
    end

    def search_paths(*paths)
      @options[:search_paths] ||= []
      return @options[:search_paths] if paths.empty?

      @options[:search_paths].concat(paths)
    end
  end
end

module Validacity
  class Configuration
    attr_reader :options

    def initialize
      @options = {}
    end

    def search_paths(*paths)
      @options[:search_paths] = paths unless paths.empty?
      @options[:search_paths]
    end
  end
end

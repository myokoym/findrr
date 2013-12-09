require "thor"
require "findrr/database"

module Findrr
  class Command < Thor
    attr_accessor :base_dir
    def initialize(*args)
      super
      @base_dir = File.join(File.expand_path("~"), ".findrr")
    end

    desc "collect PATH", "Collect filenames (take a few minutes)"
    def collect(path)
      Database.new(@base_dir).collect(path)
    end

    desc "search PART_OF_FILENAME", "Search for filenames in the collection"
    def search(part_of_filename)
      Database.new(@base_dir).search(part_of_filename)
    end
  end
end

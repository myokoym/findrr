require "thor"
require "findrr/database"

module Findrr
  class Command < Thor
    desc "collect PATH", "Collect filenames (take a few minutes)"
    def collect(path)
      Database.new.collect(path)
    end

    desc "search PART_OF_FILENAME", "Search for filenames in the collection"
    def search(part_of_filename)
      Database.new.search(part_of_filename)
    end

    desc "destroy", "Delete a database and collections"
    def destroy(path)
      Database.new.destroy
    end
  end
end

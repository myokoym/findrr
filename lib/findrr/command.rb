require "thor"
require "findrr/database"

module Findrr
  class Command < Thor
    desc "collect PATH", "Collect filenames (take a few minutes)"
    def collect(path)
      begin
        Database.new.collect(path)
      rescue => e
        $stderr.puts <<-END_OF_MESSAGE
Error: #{e.message}
Hint: table schema might be changed. Please try `findrr destroy` command.
        END_OF_MESSAGE
      end
    end

    desc "search PART_OF_FILENAME", "Search for filenames in the collection"
    def search(part_of_filename)
      Database.new.search(part_of_filename)
    end

    desc "destroy", "Delete a database and collections"
    def destroy
      Database.new.destroy
    end
  end
end

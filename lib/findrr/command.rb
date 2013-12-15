require "thor"
require "findrr/version"
require "findrr/database"
require "findrr/config"

module Findrr
  class Command < Thor
    desc "version", "Show version number"
    def version
      puts VERSION
    end

    desc "collect PATH", "Collect filenames (take a few minutes)"
    def collect(path)
      Config.new.save(path)
      begin
        Database.new.collect(path)
      rescue => e
        $stderr.puts <<-END_OF_MESSAGE
#{e.class}: #{e.message}
Hint: table schema might be changed. Please try `findrr destroy` command.
        END_OF_MESSAGE
      end
    end

    desc "search PART_OF_FILENAME", "Search for filenames in the collection"
    def search(part_of_filename)
      begin
        Database.new.search(part_of_filename)
      rescue => e
        $stderr.puts <<-END_OF_MESSAGE
#{e.class}: #{e.message}
Hint: database probably isn't created. Please try `findrr collect` command.
        END_OF_MESSAGE
      end
    end

    desc "destroy", "Delete the database and the collection"
    def destroy
      Database.new.destroy
    end
  end
end

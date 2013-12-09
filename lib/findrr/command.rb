require "thor"
require "fileutils"
require "find"
require "groonga"

module Findrr
  class Command < Thor
    attr_accessor :base_dir
    def initialize(*args)
      super
      @base_dir = File.join(File.expand_path("~"), ".findrr")
      Groonga::Context.default_options = {:encoding => :utf8}
    end

    desc "collect PATH", "Collect filenames (take a few minutes)"
    def collect(path)
      create_database_dir
      create_database
      Groonga::Database.open(database_path) do
        files = Groonga["Files"]
        Find.find(File.expand_path(path)) do |path|
          files.add(path, :basename => File.basename(path))
        end
        files.size
      end
    end

    desc "search PART_OF_FILENAME", "Search for filenames in the collection"
    def search(part_of_filename)
      Groonga::Database.open(database_path) do
        files = Groonga["Files"]
        found_files = files.select do |record|
                        record.basename =~ part_of_filename
                      end
        found_files.each do |file|
          puts file._key.force_encoding("locale")
        end
        found_files.size
      end
    end

    private
    def database_dir
      File.join(@base_dir, "db")
    end

    def database_path
      File.join(database_dir, "findrr.db")
    end

    def create_database_dir
      unless File.exist?(database_dir)
        FileUtils.mkdir_p(database_dir)
      end
    end

    def create_database
      unless File.exist?(database_path)
        Groonga::Database.create(:path => database_path)

        Groonga::Schema.create_table("Files", :type => :hash) do |table|
          table.text("basename")
        end

        Groonga::Schema.create_table("Terms",
                                     :type => :patricia_trie,
                                     :normalizer => :NormalizerAuto,
                                     :default_tokenizer => "TokenBigram") do |table|
          table.index("Files.basename")
        end
      end
    end
  end
end

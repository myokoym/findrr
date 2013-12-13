require "fileutils"
require "find"
require "groonga"

module Findrr
  class Database
    attr_accessor :base_dir
    def initialize(base_dir=default_base_dir)
      @base_dir = base_dir
      Groonga::Context.default_options = {:encoding => :utf8}
    end

    def collect(target)
      create_database_dir
      create_database
      Groonga::Database.open(database_path) do
        Groonga["Registers"].add(target)
        files = Groonga["Files"]
        Find.find(File.expand_path(target)) do |path|
          begin
          files.add(path, :basename => File.basename(path),
                          :mtime    => File.mtime(path))
          rescue Errno::ENOENT
            next
          end
        end
        files.size
      end
    end

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

    def destroy
      FileUtils.rm_rf(database_dir)
    end

    private
    def default_base_dir
      File.join(File.expand_path("~"), ".findrr")
    end

    def database_dir
      File.join(@base_dir, "db")
    end

    def database_path
      File.join(database_dir, "findrr.db")
    end

    def create_database_dir
      return if File.exist?(database_dir)
      FileUtils.mkdir_p(database_dir)
    end

    def create_database
      return if File.exist?(database_path)

      Groonga::Database.create(:path => database_path)

      Groonga::Schema.create_table("Registers", :type => :hash)

      Groonga::Schema.create_table("Files", :type => :patricia_trie) do |table|
        table.text("basename")
        table.time("mtime")
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

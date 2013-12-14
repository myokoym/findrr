require "yaml"

module Findrr
  class Config
    attr_accessor :base_dir
    def initialize(base_dir=default_base_dir)
      @base_dir = base_dir
      @config = read
    end

    def save(target)
      FileUtils.mkdir_p(@base_dir)
      @config["history"] << target
      write
    end

    private
    def default_base_dir
      File.join(File.expand_path("~"), ".findrr")
    end

    def config_path
      File.join(@base_dir, "config.yml")
    end

    def read
      if File.exist?(config_path)
        YAML.load(File.read(config_path))
      else
        {"history" => []}
      end
    end

    def write
      File.open(config_path, "w") do |file|
        YAML.dump(@config, file)
      end
    end
  end
end

require "fileutils"
require "findrr/config"

class ConfigTest < Test::Unit::TestCase
  def setup
    @tmp_dir = File.join(File.dirname(__FILE__), "tmp")
    @config_path = File.join(@tmp_dir, "config.yml")
    FileUtils.rm_f(@config_path)
    @config = Findrr::Config.new(@tmp_dir)
  end

  def teardown
    FileUtils.rm_f(@config_path)
  end

  def test_save
    @config.save("foo")
    assert_equal({"history" => ["foo"]},
                 YAML.load(File.read(@config_path)))
    @config.save("bar")
    assert_equal({"history" => ["foo", "bar"]},
                 YAML.load(File.read(@config_path)))
  end
end

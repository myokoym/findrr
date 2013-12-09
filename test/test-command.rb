require "fileutils"
require "findrr/command"

class CommandTest < Test::Unit::TestCase
  def setup
    @tmp_dir = File.join(File.dirname(__FILE__), "tmp")
    @tmp_db_dir = File.join(@tmp_dir, "db")
    FileUtils.rm_rf(@tmp_db_dir)
    @command = Findrr::Command.new
    @command.base_dir = @tmp_dir
  end

  def teardown
    FileUtils.rm_rf(@tmp_db_dir)
  end

  def test_collect_and_search
    assert_true(0 < @command.collect(File.dirname(__FILE__)))
    assert_true(0 < @command.search("test"))
  end
end

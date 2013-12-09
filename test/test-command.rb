require "fileutils"
require "findrr/command"

class CommandTest < Test::Unit::TestCase
  def setup
    @tmp_db_dir = File.join(File.dirname(__FILE__), "tmp", "db")
    FileUtils.rm_rf(@tmp_db_dir)
    FileUtils.mkdir_p(@tmp_db_dir)
    @command = Findrr::Command.new
    @command.instance_variable_set(:@database__dir, @tmp_db_dir)
  end

  def teardown
    FileUtils.rm_rf(@tmp_db_dir)
  end

  def test_collect
    assert_true(0 < @command.collect(File.dirname(__FILE__)))
  end

  def test_search
    assert_true(0 < @command.search("test"))
  end
end

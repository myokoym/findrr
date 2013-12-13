require "fileutils"
require "findrr/database"

class DatabaseTest < Test::Unit::TestCase
  def setup
    @tmp_dir = File.join(File.dirname(__FILE__), "tmp")
    @tmp_db_dir = File.join(@tmp_dir, "db")
    FileUtils.rm_rf(@tmp_db_dir)
    @database = Findrr::Database.new(@tmp_dir)
  end

  def teardown
    FileUtils.rm_rf(@tmp_db_dir)
  end

  def test_collect_and_search
    assert_true(0 < @database.collect(File.dirname(__FILE__)))
    assert_true(0 < @database.search("test"))
  end

  def test_destroy
    @database.collect(File.dirname(__FILE__))
    assert_true(File.exist?(@tmp_db_dir))
    @database.destroy
    assert_false(File.exist?(@tmp_db_dir))
  end
end

require "fileutils"
require "findrr/command"
require "findrr/database"

class CommandTest < Test::Unit::TestCase
  def setup
    @command = Findrr::Command.new
    @database = Findrr::Database.new
  end

  def test_collect
    path = "foo"
    mock(Findrr::Database).new {@database}
    mock(@database).collect(path)
    @command.collect(path)
  end

  def test_search
    part_of_filename = "bar"
    mock(Findrr::Database).new {@database}
    mock(@database).search(part_of_filename)
    @command.search(part_of_filename)
  end
end

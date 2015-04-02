require 'minitest_helper'
require 'minitest/spec'
require 'minitest/autorun'

class TestAsanaChangeLogger < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::AsanaChangesLogger::VERSION
  end

  def test_it_does_something_useful
    assert false
  end
end

describe AsanaChangesLogger do
 it "can be fun" do
  true.must_be_same_as false
 end
end
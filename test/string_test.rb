require "test_helper"

class StringTest < Minitest::Test
  def test_to_a
    assert_equal '1 2 3'.split, '1 2 3'.to_a
    assert_equal '1,2,3'.split(','), '1,2,3'.to_a(',')
    assert_equal '1,2,3'.split(',', 2), '1,2,3'.to_a(',', 2)
  end
end

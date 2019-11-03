require "test_helper"

class StringTest < Minitest::Test
  def test_to_a
    assert_equal '1 2 3'.split, '1 2 3'.to_a
    assert_equal '1,2,3'.split(','), '1,2,3'.to_a(',')
    assert_equal '1,2,3'.split(',', 2), '1,2,3'.to_a(',', 2)
  end

  def test_to_regexp
    assert_equal(/^[0-9A-Za-z]+$/, '^[0-9A-Za-z]+$'.to_regexp)
    assert_equal(/^[0-9A-Za-z]+$/, '^[0-9A-Za-z]+$'.to_re)
  end
end

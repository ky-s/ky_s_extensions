require "test_helper"

class RangeTest < Minitest::Test
  def test_array_methods
    assert_equal 15, (1..5).sum
    assert_equal 1.step(100, 2).to_a, (1..100).select(&:odd?)
    error = assert_raises(NoMethodError) { (1..100).no_method }
    assert_match(/^undefined.*for.*Range/, error.message, error)
  end
end

require "test_helper"

class EnumeratorTest < Minitest::Test
  def test_array_methods
    assert_equal 15, (1..5).each.sum
    assert_equal 1.step(100, 2).to_a, (1..100).each.select(&:odd?)
    error = assert_raises(NoMethodError) { (1..100).each.no_method }
    assert_match(/^undefined.*for.*Enumerator/, error.message, error)
  end
end


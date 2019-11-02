require "test_helper"

class CumlativeTest < Minitest::Test
  def test_cumsum
    assert_equal [1, 3, 6], [1, 2, 3].cumsum
    assert_equal [1.0, 3.0], [1.0, 2.0].cumsum
  end
end

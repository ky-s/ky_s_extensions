require "test_helper"

class ArrayStackAndQueueTest < Minitest::Test
  def test_unshift!
    arr = [1, 2, 3]
    arr.unshift!(4, 5)
    assert_equal [4, 5, 1, 2, 3], arr
  end

  def test_shift!
    arr = [1, 2, 3]
    shifted = arr.shift!(2)
    assert_equal [1, 2], shifted
    assert_equal [3], arr
  end

  def test_push!
    arr = [1, 2, 3]
    arr.push!(4, 5)
    assert_equal [1, 2, 3, 4, 5], arr
  end

  def test_pop!
    arr = [1, 2, 3]
    shifted = arr.pop!(2)
    assert_equal [2, 3], shifted
    assert_equal [1], arr
  end

  def test_nunshift
    arr = [1, 2, 3]
    new_arr = arr.nunshift(4, 5)
    assert_equal [4, 5, 1, 2, 3], new_arr
    assert_equal [1, 2, 3], arr
  end

  def test_nshift
    arr = [1, 2, 3]
    shifted, new_arr = arr.nshift(2)
    assert_equal [1, 2], shifted
    assert_equal [3], new_arr
    assert_equal [1, 2, 3], arr
  end

  def test_npush
    arr = [1, 2, 3]
    new_arr = arr.npush(4, 5)
    assert_equal [1, 2, 3, 4, 5], new_arr
    assert_equal [1, 2, 3], arr
  end

  def test_npop
    arr = [1, 2, 3]
    shifted, new_arr = arr.npop(2)
    assert_equal [2, 3], shifted
    assert_equal [1], new_arr
    assert_equal [1, 2, 3], arr
  end
end

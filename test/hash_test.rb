require "test_helper"

class HashTest < Minitest::Test
  def setup
    @hsh = { :foo => 3, 'bar' => 4, ['baz'] => 5, nil => false, false => nil }
  end
  def test_has_all_keys?
    assert @hsh.has_all_keys?(:foo)
    refute @hsh.has_all_keys?('foo')
    assert @hsh.has_all_keys?(nil)
    assert @hsh.has_all_keys?('bar', ['baz'], false)
    refute @hsh.has_all_keys?('bar', [:baz])
  end

  def test_slice_required
    assert_equal({ :foo => 3 }, @hsh.slice_required(:foo))
    assert_equal({ nil => false, false => nil }, @hsh.slice_required(nil, false))

    error = assert_raises(ArgumentError) { @hsh.slice_required(:hoge) }
    assert_match(/^required key/, error.message, error)
  end

  def test_slice_required_key_set
    assert_equal({ :foo => 3 }, @hsh.slice_required_key_set(:foo, ['bar', ['baz']]))
    assert_equal({ :foo => 3 }, @hsh.slice_required_key_set([:foo], ['bar', ['baz']]))
    assert_equal({ 'bar' => 4, ['baz'] => 5 }, @hsh.slice_required_key_set(['bar', ['baz']], :foo))
    assert_equal({ 'bar' => 4, ['baz'] => 5 }, @hsh.slice_required_key_set(['bar', ['baz']], :hoge, :fuga))
    assert_equal({ 'bar' => 4, ['baz'] => 5 }, @hsh.slice_required_key_set(:hoge, :fuga, ['bar', ['baz']]))

    error = assert_raises(ArgumentError) { @hsh.slice_required_key_set }
    assert_match(/^required key set/, error.message, error)

    error = assert_raises(ArgumentError) { @hsh.slice_required_key_set(:hoge, :fuga) }
    assert_match(/^required key sets/, error.message, error)
  end
end

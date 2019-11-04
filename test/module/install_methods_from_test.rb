require "test_helper"

class ModuleInstallMethodsFromTest < Minitest::Test
  class FakeArray  < Array;  end
  class FakeString < String; end
  class FakeHash   < Hash;   end

  class FakeRange < Range
    install_methods_from FakeArray,  :to_arr
    install_methods_from FakeString, :to_str,  methods: :succ
    install_methods_from FakeHash,   :to_hash, methods: [:keys, :has_key?], follow: true

    def to_arr
      FakeArray.new(to_a)
    end

    def to_str
      FakeString.new(to_a[-1].to_s)
    end

    def to_hash
      FakeHash.new.tap { |h| h[:key] = self }
    end
  end

  class FakeArray < Array
    def new_method_arr # FakeRange is following
      'new method_arr'
    end
  end

  class FakeString < String
    def new_method_str # FakeRange is not folloing
      'new method_str'
    end
  end

  class FakeHash < Hash
    def new_method_hash # FakeRange is following
      'new method_hash'
    end
  end

  def test_install_methods_from_fake_array
    assert_includes FakeRange.instance_methods, :[]
    assert_includes FakeRange.instance_methods, :new_method_arr
    assert_equal 100,   FakeRange.new(1, 100)[-1]
  end

  def test_install_methods_from_fake_string
    assert_includes FakeRange.instance_methods, :succ
    refute FakeRange.instance_methods.include?(:new_method_str)
    assert_equal '101', FakeRange.new(1, 100).succ
  end

  def test_install_methods_from_fake_hash
    assert_includes FakeRange.instance_methods, :keys
    assert_includes FakeRange.instance_methods, :has_key?
    assert_includes FakeRange.instance_methods, :new_method_hash
    assert_equal [:key], FakeRange.new(1, 100).keys
    assert FakeRange.new(1, 100).has_key?(:key)
  end
end

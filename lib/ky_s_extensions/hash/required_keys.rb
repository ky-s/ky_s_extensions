class Hash
  # as variadic Hash:has_key?
  def has_all_keys?(*verify_keys)
    keys & verify_keys == verify_keys
  end

  # if any required key is missing, throw ArgumentError.
  # otherwise call Hash:slice.
  # { 'key1' => 1, 'key2' => 2, 'key3' => 3 }.slice_required('key1', 'key2')
  # # =>{ 'key1' => 1, 'key2' => 2 }
  #
  # { 'key1' => 1, 'key2' => 2, 'key3' => 3 }.slice_required(:key1)
  # # => ArgumentError
  def slice_required(*required_keys)
    has_all_keys?(*required_keys) or
      raise ArgumentError, "required key: #{(required_keys - keys).join(',')} was not present."
    slice(*required_keys)
  end

  # 引数にいくつかの キーセットを 与えられると、
  # それらのセットごとに、含まれるキーをすべて持っているか検証します。
  # いずれのキーセットも満たすことができなければ ArgumentError を投げます。
  # そうでなければ、最初に満たしたキーセットで slice した結果を返します。
  # { 'key1' => 1, 'key2' => 2, 'key3 => 3 }.slice_required_key_set(:key1, ['key2', 'key3'])
  # # => { 'key2' => 2, 'key3 => 3 }
  #
  # { 'key1' => 1, 'key2' => 2, 'key3 => 3 }.slice_required_key_set('key4',['key1', 'key5'] )
  # # => ArgumentError
  def slice_required_key_set(*required_sets)
    required_sets.size == 0 and
      raise ArgumentError, 'required key sets were not given.'

    valid_set = required_sets.detect { |set| has_all_keys?(*set) }

    unless valid_set
      raise ArgumentError, "required key sets: #{required_sets.inspect} were not any present."
    end
    slice(*valid_set)
  end
end

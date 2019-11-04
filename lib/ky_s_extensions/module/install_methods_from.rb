class Module
  # klass に指定した class の持つ instance_methods をすべて定義します。
  # converter に指定したメソッドで自身を klass に変換してから対象のメソッドをコールするようになります。
  # 自身が持っているメソッドと名称が重複した場合は自身のメソッドが優先されます。
  # インストール後に追加されたメソッドも method_added イベントによって追随しますが、
  # 削除、未定義にされたメソッドは追随しません。
  # 削除されたメソッドが install_methods_from によって追加されたメソッドかどうかを判定できないためです。
  #
  # [args]
  # klass           ... インストール元クラスオブジェクト
  # converter       ... 現在のオブジェクトを klass オブジェクトに変換するメソッド
  # converter_args  ... converter の引数オプション
  # methods         ... インストールする対象メソッド (default: 全インスタンスメソッド)
  # follow          ... 今後追加したメソッドに追随するか。
  #                     default は、 methods が明示的に渡されたら false 、なければ true です。
  # e.g.
  # class RangeArray < Range
  #   install_methods_from Array, :to_a
  #   install_methods_from String, :to_s, methods: :succ
  # end
  #
  # RangeArray.new(1, 100)[-1]
  # # => 100
  # RangeArray.new(1, 100).succ
  # # => "1..101"
  #
  def install_methods_from(klass, converter, *converter_args, methods: nil, follow: methods.nil?)
    (Array(methods || klass.instance_methods) - self.instance_methods).each do |method|
      define_method method do |*args|
        send(converter, *converter_args).send(method, *args)
      end
      # puts "#{self}:#{method} installed from #{klass}."
    end

    if follow
      install_class = self
      # prepend module that has method_added with add the method to self, too.
      klass.singleton_class.prepend(
        Module.new do
          define_method :method_added do |method|
            install_class.define_method method do |*args|
              send(converter, *converter_args).send(method, *args)
            end

            super(method)
          end
        end
      )
    end
  end
end


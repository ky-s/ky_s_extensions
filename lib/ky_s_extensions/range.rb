class Range
  # if the method is missing but Array has it,
  # convert to Array and call it.
  def method_missing(method, *args)
    if to_a.respond_to?(method)
      to_a.send(method, *args)
    else
      super(method, *args)
    end
  end
end

# Stack methods and Queue methods
class Array
  # alias bang methods
  alias_method :unshift!, :unshift
  alias_method :shift!,   :shift
  alias_method :push!,    :push
  alias_method :pop!,     :pop

  # does not change receiver directly.
  def nunshift(*args)
    dup.unshift!(*args)
  end

  # does not change receiver directly.
  #   returns shifted items and remains.
  def nshift(*args)
    d = dup
    [d.shift!(*args), d]
  end

  # does not change receiver directly.
  def npush(*args)
    dup.push!(*args)
  end

  # does not change receiver directly.
  #   returns popped items and remains.
  def npop(*args)
    d = dup
    [d.pop!(*args), d]
  end
end

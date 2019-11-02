class String
  alias_method :to_a, :split

  def to_regexp
    /#{self}/
  end

  alias_method :to_re, :to_regexp
end

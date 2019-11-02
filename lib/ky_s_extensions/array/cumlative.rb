# Cumlative method.
class Array
  # cumlative array sum
  # [1, 2, 3].cumsum # => [1, 3, 6]
  def cumsum
    size.times.map { |i| self[0..i].sum }
  end
end

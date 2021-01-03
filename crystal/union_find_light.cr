class UnionFind
  getter size : Int32
  getter parents : Array(Int32)

  def initialize(@size)
    @parents = Array.new(@size, -1)
  end

  def unite(a, b)
    a = root(a)
    b = root(b)
    return if a == b

    a, b = b, a if -@parents[a] < -@parents[b]
    @parents[a] += @parents[b]
    @parents[b] = a
  end

  def root(a)
    @parents[a] < 0 ? a : (@parents[a] = root(@parents[a]))
  end

  def same?(a, b)
    root(a) == root(b)
  end

  def size(a)
    -@parents[a]
  end

  def groups
    (0 ... @size).group_by{ |i| root(i) }.values
  end

  def each_group
    (0 ... @size).group_by{ |i| root(i) }.each_value
  end
end

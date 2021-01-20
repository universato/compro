class UnionFind
  def initialize(n)
    @parents = Array.new(n, -1) # Each root has negative value which means size.
  end

  def unite(a, b)
    a = root(a)
    b = root(b)
    return false if a == b

    a, b = b, a if -@parents[a] < -@parents[b]
    @parents[a] += @parents[b] # Negative value means size
    @parents[b] = a
  end

  def root(a)
    @parents[a] < 0 ? a : (@parents[a] = root(@parents[a]))
  end

  def same?(a, b)
    root(a) == root(b)
  end

  def size(a)
    -@parents[root(a)]
  end

  def groups
    (0 ... @parents.size).group_by{ |i| leader(i) }.values
  end

  def each_group
    (0 ... @parents.size).group_by{ |i| leader(i) }.each_value
  end
end

class UnionFind
  getter size : Int32
  getter parents : Array(Int32)

  def initialize(@size : Int32)
    @parents = Array.new(@size, -1)
  end

  def unite(a, b)
    raise ArgumentError.new unless (0 <= a < @size) && (0 <= b < @size)

    a = root(a)
    b = root(b)
    return if a == b

    a, b = b, a if -@parents[a] < -@parents[b]
    @parents[a] += @parents[b]
    @parents[b] = a
  end

  def root(a) : Int32
    raise ArgumentError.new unless 0 <= a < @size
    @parents[a] < 0 ? a : (@parents[a] = root(@parents[a]))
  end

  def same?(a, b) : Bool
    raise ArgumentError.new unless (0 <= a < @size) && (0 <= b < @size)
    root(a) == root(b)
  end

  def size(a) : Int32
    raise ArgumentError.new unless 0 <= a < @size
    -@parents[a]
  end

  def groups
    (0 ... @size).group_by{ |i| root(i) }.values
  end

  def each_group
    (0 ... @size).group_by{ |i| root(i) }.each_value
  end
end

# uf = UnionFind.new(8)
# uf.unite(1, 2)
# p uf.root(8)

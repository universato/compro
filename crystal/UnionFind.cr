class UnionFind
  getter size : Int32
  getter parents : Array(Int32)

  def initialize(@size : Int32)
    @parents = Array.new(@size, -1)
  end

  macro check_range(x)
    raise ArgumentError.new("[UnionFind Error]#{{{x}}} is not in [0, #{@size})") unless (0 <= {{x}} < @size)
  end

  def unite(a, b)
    check_range(a)
    check_range(b)

    a = root(a)
    b = root(b)
    return if a == b

    a, b = b, a if -@parents[a] < -@parents[b]
    @parents[a] += @parents[b]
    @parents[b] = a
  end

  def root(a) : Int32
    check_range(a)
    @parents[a] < 0 ? a : (@parents[a] = root(@parents[a]))
  end

  def same?(a, b) : Bool
    check_range(a)
    check_range(b)
    root(a) == root(b)
  end

  def size(a) : Int32
    check_range(a)
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

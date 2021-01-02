class UnionFind
  # attr_accessor :parents
  def initialize(n)
    raise ArgumentError if n < 0

    @n = n
    @rank = Array.new(n, 0)
    @size = Array.new(n, 0)
    @parents = Array.new(n, -1)
  end

  def unite(a, b)
    raise ArgumentError unless 0 <= a && a < @n

    a = root(a)
    b = root(b)
    return false if a == b

    a, b = b, a if @rank[a] < @rank[b]
    @rank[a] += 1 if @rank[a] == @rank[b]
    @parents[a] += @parents[b] # negative value means size
    @size[a] += @size[b]
    @size[b] = @size[a]
    @parents[b] = a
  end

  def unite_by_size(a, b)
    raise ArgumentError unless 0 <= a && a < @n

    a = root(a)
    b = root(b)
    return false if a == b

    a, b = b, a if @size[a] < @size[b]
    @size[a] += @size[b]
    @parents[a] += @parents[b] # negative value means size
    @parents[b] = a
  end

  def unite_by_rank(a, b)
    raise ArgumentError unless 0 <= a && a < @n

    a = root(a)
    b = root(b)
    return false if a == b

    a, b = b, a if @rank[a] < @rank[b]
    @rank[a] += 1 if @rank[a] == @rank[b]
    @parents[a] += @parents[b] # negative value means size
    @parents[b] = a
  end

  def root(a)
    raise ArgumentError unless 0 <= a && a < @n

    @parents[a] < 0 ? a : (@parents[a] = root(@parents[a]))
  end

  def same?(a, b)
    root(a) == root(b)
  end

  def size(a)
    raise ArgumentError unless 0 <= a && a < @n

    -parents[root(a)]
  end

  def groups
    (0 ... @parent_or_size.size).group_by{ |i| leader(i) }.values
  end

  def each_group
    (0 ... @parent_or_size.size).group_by{ |i| leader(i) }.each_value
  end
end

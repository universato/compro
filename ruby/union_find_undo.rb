# https://ei1333.github.io/luzhiled/snippets/structure/union-find.html

class UnionFind
  def initialize(n)
    @n = n
    @parents = Array.new(n, -1)
    @history = []
  end
  attr_accessor :parents, :history

  def unite(a, b)
    raise ArgumentError unless a < @n && b < @n

    a = root(a)
    b = root(b)
    history << [a, parents[a]]
    history << [b, parents[b]]
    return false if a == b

    a, b = b, a if -@parents[a] < -@parents[b]
    @parents[a] += @parents[b] # Negative value means size
    @parents[b] = a
  end
  alias merge unite

  def root(a)
    raise ArgumentError unless a < @n

    @parents[a] < 0 ? a : root(@parents[a])
  end

  def same?(a, b)
    raise ArgumentError unless a < @n && b < @n

    root(a) == root(b)
  end

  def size(a)
    raise ArgumentError unless a < @n

    -@parents[root(a)]
  end

  def undo
    (a, pa), (b, pb) = @history.pop(2)
    @parents[a] = pa
    @parents[b] = pb
  end

  def snapshot
    @history = []
  end

  def rollback
    undo until @history.empty?
  end

  def groups
    (0 ... @parents.size).group_by{ |i| root(i) }.values
  end
end

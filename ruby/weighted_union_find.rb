class WeightedUnionFind
  def initialize(n)
    @parents = Array.new(n, -1)
    @diffs = Array.new(n, 0)
  end
  attr_accessor :parents, :diffs

  def root(x)
    if @parents[x] < 0
      x
    else
      y = root(@parents[x])
      @diffs[x] += @diffs[@parents[x]] # 累積和をとる
      @parents[x] = y
    end
  end

  def unite(a, b, w)
    # x と y それぞれについて、 root との重み差分を補正
    # p weight(b)
    w += weight(a)
    w -= weight(b)

    a = root(a)
    b = root(b)
    if a == b
      return if w == diff(a, b)

      raise ArgumentError
    end

    if -@parents[a] < -@parents[b]
      @parents[b] += @parents[a]
      @parents[a] = b
      @diffs[a] = -w
    else
      @parents[a] += @parents[b]
      @parents[b] = a
      @diffs[b] = w
    end
  end
  alias merge unite

  def same?(a, b)
    root(a) == root(b)
  end

  def size(a)
    -@parents[root(a)]
  end

  def weight(x)
    root(x) # path compression
    @diffs[x]
  end

  def diff(x, y)
    same?(x, y) ? weight(y) - weight(x) : nil
  end
end
WeightedUnionFindTree = WeightedUnionFind

def dsl_1_b
  n, q = gets.split.map(&:to_i)
  uft = WeightedUnionFind.new(n)
  q.times do
    f, a, b, w = gets.split.map(&:to_i)

    if f == 0
      uft.unite(a, b, w)
    else
      puts uft.diff(a, b) || '?'
    end
  end
end

def arc090
  # ABC087 - D, ARC090 - B
  n, m = gets.split.map(&:to_i)
  wuf = WeightedUnionFind.new(n)
  m.times do
    l, r, d = gets.split.map(&:to_i)
    l -= 1
    r -= 1
    if (diff = wuf.diff(l, r))
      next if d == diff

      puts "No"
      exit
    else
      wuf.unite(l, r, d)
    end
  end

  puts "Yes"
end

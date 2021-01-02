class Node
  attr_accessor :parent, :rank, :weight, :diff_weight

  def initialize
    @parent = -1 # Positive value means its parent,and Negative value means its size.
    @rank = 0
    @diff_weight = 0
  end
end

class WeightedUnionFind
  def initialize(n)
    @nodes = Array.new(n){ Node.new }
  end

  def find(x)
    if @nodes[x].parent < 0
      x
    else
      y = find(@nodes[x].parent)
      @nodes[x].diff_weight += @nodes[@nodes[x].parent].diff_weight # 累積和をとる
      @nodes[x].parent = y
    end
  end
  alias root find

  def unite(a, b, w)
    # x と y それぞれについて、 root との重み差分を補正
    # p weight(b)
    w += weight(a)
    w -= weight(b)

    a = root(a)
    b = root(b)
    return if a == b

    if @nodes[a].rank < @nodes[b].rank
      @nodes[b].parent += @nodes[a].parent
      @nodes[a].parent = b
      @nodes[a].diff_weight = -w
    else
      @nodes[a].parent += @nodes[b].parent
      @nodes[b].parent = a
      @nodes[a].rank += 1 if @nodes[a].rank == @nodes[b].rank
      @nodes[b].diff_weight = w
    end
  end

  def same?(a, b)
    root(a) == root(b)
  end

  def size(a)
    -@nodes[find(a)].parent
  end

  def weight(x)
    root(x) # 経路圧縮
    @nodes[x].diff_weight
  end

  def diff(x, y)
    return nil unless same?(x, y) # つながってなければ距離を測れないのでnilを返す

    weight(y) - weight(x)
  end

  # 確認用。アルゴリズムとは関係無い
  def parents; @nodes.map{|i|i.parent} end
  def ranks; @nodes.map{|i|i.rank} end
  def diff_weight; @nodes.map{|i|i.diff_weight} end
end

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

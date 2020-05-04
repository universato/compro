class UnionFind

  #attr_accessor :parents
  def initialize(size)
    @rank = Array.new(size, 0)
    @parents = Array.new(size, -1)
  end

  def unite(a, b)
    a = root(a)
    b = root(b)
    return if a == b

    if @rank[a] > @rank[b]
      @parents[b] = a
    else
      @parents[a] = b
      @rank[b] += 1 if @rank[a] == @rank[b]
    end
  end

  def root(a)
    @parents[a] < 0 ? a : (@parents[a] = root(@parents[a]))
  end

  def same?(a, b)
    root(a) == root(b)
  end
end

require 'minitest/autorun'

class UnionFind_Test < Minitest::Test

  def test_atcoder_typical_true
    uft = UnionFind.new(8)
    query = [[0,1,2], [0,3,2], [1,1,3], [0,2,4], [1,4,1],[0,4,2],[0,0,0],[1,0,0]]
    query.each do |(q,a,b)|
      if q == 0
        uft.unite(a,b)
      else
        assert uft.same?(a,b)
      end
    end
  end
  def test_aizu_sample_true
    uft = UnionFind.new(5)
    query = [[0, 1, 4],[0, 2, 3],[1, 1, 4],[1, 3, 2],[0, 1, 3],[1, 2, 4],[0, 0, 4],[1, 0, 2],[1, 3, 0]]
    query.each do |(q,a,b)|
      if q == 0
        uft.unite(a,b)
      else
        assert uft.same?(a,b)
      end
    end
  end
  def test_aizu_sample_false
    uft = UnionFind.new(5)
    query = [[0, 1, 4],[0, 2, 3],[1, 1, 2],[1, 3, 4],[0, 1, 3],[1, 3, 0],[0, 0, 4]]
    query.each do |(q,a,b)|
      if q == 0
        uft.unite(a,b)
      else
        assert !uft.same?(a,b)
      end
    end
  end
  def test_rand
    n = 100
    uft = UnionFind.new(n)
    n.times do
      a = rand(n)
      b = rand(n)
      next if a == b
      assert !uft.same?(a,b)
    end
  end
end

# https://atc001.contest.atcoder.jp/tasks/unionfind_a
# n,q=gets.split.map &:to_i
# tr=UnionFind.new(n+1)
#
# q.times do
#   qu,a,b=gets.split.map &:to_i
#   if qu==0
#     tr.unite(a,b)
#   else
#     puts tr.root(a) == tr.root(b) ? "Yes" : "No"
#   end
# end

require 'minitest'
require 'minitest/autorun'

require_relative '../union_find_experimental.rb'

class UnionFindTest < Minitest::Test
  def test_atcoder_typical_true
    uft = UnionFind.new(8)
    query = [[0, 1, 2], [0, 3, 2], [1, 1, 3], [0, 2, 4], [1, 4, 1], [0, 4, 2], [0, 0, 0], [1, 0, 0]]
    query.each do |(q, a, b)|
      if q == 0
        uft.unite(a, b)
      else
        assert uft.same?(a, b)
      end
    end
  end

  def test_aizu_sample_true
    uft = UnionFind.new(5)
    query = [[0, 1, 4], [0, 2, 3], [1, 1, 4], [1, 3, 2], [0, 1, 3], [1, 2, 4], [0, 0, 4], [1, 0, 2], [1, 3, 0]]
    query.each do |(q, a, b)|
      if q == 0
        uft.unite(a, b)
      else
        assert uft.same?(a, b)
      end
    end
  end

  def test_aizu_sample_false
    uft = UnionFind.new(5)
    query = [[0, 1, 4], [0, 2, 3], [1, 1, 2], [1, 3, 4], [0, 1, 3], [1, 3, 0], [0, 0, 4]]
    query.each do |(q, a, b)|
      if q == 0
        uft.unite(a, b)
      else
        assert !uft.same?(a, b)
      end
    end
  end

  def test_rand_isoration
    n = 100
    uft = UnionFind.new(n)
    n.times do
      a = rand(n)
      b = rand(n)
      next if a == b

      assert !uft.same?(a, b)
    end
  end

  def test_unite_by_size
    n = 100
    uf0 = UnionFind.new(n)
    uf1 = UnionFind.new(n)
    uf2 = UnionFind.new(n)
    n.times do
      a = rand(n)
      b = rand(n)
      uf0.unite(a, b)
      uf1.unite_by_size(a, b)
      uf2.unite_by_rank(a, b)
      assert uf0.same?(a, b)
      assert uf1.same?(a, b)
    end
    n.times do
      a = rand(n)
      b = rand(n)
      assert_equal uf0.same?(a, b), uf1.same?(a, b)
      assert_equal uf0.same?(a, b), uf2.same?(a, b)
    end
  end
end

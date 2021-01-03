require 'minitest'
require 'minitest/autorun'

require_relative '../union_find_undo.rb'

class UnionFindTest < Minitest::Test
  def test_undo
    uf = UnionFind.new(5)
    uf.unite(0, 1)
    uf.unite(0, 2)
    assert 3, uf.size(2)
    assert uf.same?(0, 1)
    assert uf.same?(1, 2)

    uf.undo
    assert 1, uf.size(2)
    assert uf.same?(0, 1)
  end

  def test_snapshot
    uf = UnionFind.new(5)
    uf.unite(0, 1)
    uf.unite(0, 2)
    assert uf.same?(0, 2)

    uf.snapshot

    uf.unite(0, 3)
    assert uf.same?(0, 3)

    uf.undo
    assert_equal 3, uf.size(2)
    assert uf.same?(0, 2)
    assert !uf.same?(0, 3)
  end

  def test_rollback
    uf = UnionFind.new(5)
    uf.unite(0, 1)
    uf.unite(0, 2)
    uf.rollback
    assert_equal [[0], [1], [2], [3], [4]], uf.groups

    uf.unite(0, 1)
    uf.unite(0, 2)
    uf.snapshot

    uf.unite(0, 3)
    uf.unite(3, 4)
    uf.rollback
    assert uf.same?(0, 1)
    assert uf.same?(1, 2)
    assert !uf.same?(0, 3)
    assert !uf.same?(3, 4)
  end

  def test_atcoder_typical_true
    uft = UnionFind.new(8)
    query = [[0, 1, 2], [0, 3, 2], [1, 1, 3], [0, 2, 4], [1, 4, 1], [0, 4, 2], [0, 0, 0], [1, 0, 0]]
    query.each do |(q, a, b)|
      if q == 0
        uft.unite(a, b)
      else
        assert uft.same?(a, b)
      end
      assert_equal uft.size(a), uft.size(b)
    end
  end

  def test_aizu_sample_true
    uft = UnionFind.new(5)
    query = [[0, 1, 4], [0, 2, 3], [1, 1, 4], [1, 3, 2], [0, 1, 3], [1, 2, 4], [0, 0, 4], [1, 0, 2], [1, 3, 0]]
    query.each do |(q, a, b)|
      if q == 0
        uft.unite(a, b)
        assert_equal uft.size(a), uft.size(b)
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
        assert_equal uft.size(a), uft.size(b)
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
end

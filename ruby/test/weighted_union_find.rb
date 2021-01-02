require 'minitest'
require 'minitest/autorun'

require_relative '../weighted_union_find.rb'

class WeightedUnionFindTest < Minitest::Test
  def test_dsl_1_b
    wuf = WeightedUnionFind.new(5)

    wuf.unite(0, 2, 5)
    wuf.unite(1, 2, 3)
    assert_equal 2, wuf.diff(0, 1)
    assert_nil      wuf.diff(1, 3)

    wuf.unite(1, 4, 8)
    assert_equal 10, wuf.diff(0, 4)
  end
end

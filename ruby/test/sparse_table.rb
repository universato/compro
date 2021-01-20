require_relative '../sparse_table.rb'

require 'minitest'
require 'minitest/autorun'

class SparseTableTest < Minitest::Test
  def test_sparseTable
    st = SparseTableMin.new([1, 2, 3, 2])
    assert_equal 1, st.rmq(0, 1)
    assert_equal 1, st.rmq(0, 2)
    assert_equal 1, st.rmq(0, 3)
    assert_equal 2, st.rmq(1, 2)
    assert_equal 2, st.rmq(1, 3)
    assert_equal 2, st.rmq(1, 4)

    st = SparseTableMin.new([3, 2, 1])
    assert_equal 3, st.rmq(0, 1)
    assert_equal 2, st.rmq(0, 2)
    assert_equal 1, st.rmq(0, 3)
    assert_equal 1, st.rmq(1, 3)
    assert_equal 1, st.rmq(2, 3)

    st = SparseTableMin.new([2, 1, 3, 1])
    assert_equal 2, st.rmq(0, 1)
    assert_equal 1, st.rmq(0, 2)
    assert_equal 1, st.rmq(0, 3)

    st = SparseTableMin.new([2, 1, 3, 1])
    assert_equal 2, st.rmq(0, 1)
    assert_equal 1, st.rmq(0, 2)
    assert_equal 1, st.rmq(0, 3)
  end
end

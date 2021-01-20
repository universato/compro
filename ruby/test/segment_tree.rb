require 'minitest'
require 'minitest/autorun'

require_relative "../segment_tree"

class SegmentTreeTest < Minitest::Test
  def test_get_min
    n = 3
    st = SegmentTree.new(n)
    assert_equal 2**31 - 1, st.inf
    st.update(0, 1)
    st.update(1, 2)
    st.update(2, 3)
    assert_equal 1, st.get_min(0, 2)
    assert_equal 2, st.get_min(1, 2)
  end

  def test_get_min
    st = [7, 6, 8].to_st(:gcd)
    # st.update_gcd(0, 1)
    # st.update(1, 2)
    # st.update(2, 3)
    assert_equal 7, st.get_gcd(0, 1)
    assert_equal 2, st.get_gcd(1, 3)
  end
end

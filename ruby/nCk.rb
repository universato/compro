def nck(n, k)
  return 0 if k < 0 || n < k

  ret = 1/1r
  k = [k, n - k].min
  k.times do
    ret = ret * n / k
    n -= 1
    k -= 1
  end
  ret.to_i
end

require "minitest/autorun"
class CombinationTest < Minitest::Test
  def test_nck
    assert_equal 1, nck(3, 0)
    assert_equal 3, nck(3, 1)
    assert_equal 3, nck(3, 2)
    assert_equal 1, nck(3, 3)

    assert_equal 1, nck(4, 0)
    assert_equal 4, nck(4, 1)
    assert_equal 6, nck(4, 2)
    assert_equal 4, nck(4, 3)
    assert_equal 1, nck(4, 4)
  end
end

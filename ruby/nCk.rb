class Integer
  def nCk(k)
    n = self
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
end

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

  def test_integer_nck
    assert_equal 1, 3.nCk(0)
    assert_equal 3, 3.nCk(1)
    assert_equal 3, 3.nCk(2)
    assert_equal 1, 3.nCk(3)

    assert_equal 1, 4.nCk(0)
    assert_equal 4, 4.nCk(1)
    assert_equal 6, 4.nCk(2)
    assert_equal 4, 4.nCk(3)
    assert_equal 1, 4.nCk(4)
  end
end

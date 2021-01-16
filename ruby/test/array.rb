require 'minitest'
require 'minitest/autorun'

require_relative '../array.rb'

class ArrayTest < Minitest::Test
  def test_comparison_operator
    assert [] < [5]
    assert [] < %w[a b]
    assert [1, 2, 3] < [3, 4, 5]
    assert [3, 4, 5] > [1, 2, 3]
    assert [1, 1, 1] == [1, 1, 1]
    assert [1, 1] < [1, 1, 1]
    assert [1, 2] > [1, 1, 1]
    assert [1, 1] <= [1, 1, 1]
    assert [1, 2] >= [1, 1, 1]
    assert %w[a b c] < %w[a b d]
    assert %w[a b c] < %w[a b c d]
  end

  def test_abs_method
    assert_equal [], [].abs
    assert_equal [1, 2, 3], [1, 2, 3].abs
    assert_equal [1], [-1].abs
    assert_equal [0, 1, 1], [0, -1, -1].abs
  end

  def test_abs!
    assert_equal [], [].abs!
    assert_equal [1, 2, 3], [1, 2, 3].abs!
    assert_equal [1], [-1].abs!
    assert_equal [0, 1, 1], [0, -1, -1].abs!
  end

  def test_cumgcd
    assert_equal([], [].cumgcd)
    assert_equal([1], [1].cumgcd)
    assert_equal([1, 1, 1], [1, 2, 3].cumgcd)
    assert_equal([3, 1, 1], [3, 2, 1].cumgcd)
    assert_equal([3, 3, 3], [3, 3, 3].cumgcd)
    assert_equal([12, 6, 2], [12, 6, 2].cumgcd)
    assert_equal([24, 12, 3], [24, 36, 9].cumgcd)
  end

  def test_cummax
    assert_equal([], [].cummax)
    assert_equal([1], [1].cummax)
    assert_equal([1, 2, 3], [1, 2, 3].cummax)
    assert_equal([3, 3, 3], [3, 2, 1].cummax)
    assert_equal([3, 3, 3], [3, 3, 3].cummax)
    assert_equal([12, 12, 12], [12, 6, 2].cummax)
    assert_equal([24, 36, 36], [24, 36, 9].cummax)
    assert_equal([-6, -2, 10, 10], [-6, -2, 10, -5].cummax)
  end

  def test_cumsum
    assert_equal([], [].cumsum)
    assert_equal([1], [1].cumsum)
    assert_equal([1, 3, 6], [1, 2, 3].cumsum)
    assert_equal([3, 5, 6], [3, 2, 1].cumsum)
    assert_equal([3, 6, 9], [3, 3, 3].cumsum)
    assert_equal([12, 18, 20], [12, 6, 2].cumsum)
    assert_equal([24, 60, 69], [24, 36, 9].cumsum)
    assert_equal([-1, 0, -1, 0], [-1, 1, -1, 1].cumsum)
  end

  def test_deru_kui
    assert_equal [], [].deru_kui(100)
    assert_equal [], [].deru_kui(-100)
    assert_equal [0, 10, 20, 50], [0, 10, 20, 100].deru_kui(50)
    assert_equal [-5, 3, 10, 20], [-5, 3, 10, 100].deru_kui(20)
    assert_equal [-5, 3, 3, 3], [-5, 3, 10, 100].deru_kui(3)
    assert_equal [0, -4, -5, 0], [3, -4, -5, 6].deru_kui(0)
  end

  def test_diff
    assert_equal [], [].diff
    assert_equal [], [1].diff
    assert_equal [10, 10, 80], [0, 10, 20, 100].diff
    assert_equal [8, 7, 90], [-5, 3, 10, 100].diff
    assert_equal [-7, -1, 11], [3, -4, -5, 6].diff
  end

  def test_fd
    assert_equal [0] * 6, [].fd(5)
    assert_equal [1] * 6, [0, 1, 2, 3, 4, 5].fd
    assert_equal [0, 3], [1, 1, 1].fd
    assert_equal [0, 1, 0, 3, 1, 2], [5, 1, 4, 5, 3, 3, 3].fd
    n = rand(1..100)
    assert_equal [0] * (n + 1), [].fd(n)
  end

  def test_gcd
    assert_equal 0, [].gcd
    assert_equal 1, [1].gcd
    assert_equal 1, [1, 2, 3].gcd
    assert_equal 1, [3, 2, 1].gcd
    assert_equal 3, [3, 3, 3].gcd
    assert_equal 2, [12, 6, 2].gcd
    assert_equal 3, [24, 36, 9].gcd
  end

  def test_gcd?
    assert_nil [].gcd?
    assert_equal 1, [1].gcd?
    assert_equal 1, [1, 2, 3].gcd?
    assert_equal 1, [3, 2, 1].gcd?
    assert_equal 3, [3, 3, 3].gcd?
    assert_equal 2, [12, 6, 2].gcd?
    assert_equal 3, [24, 36, 9].gcd?
  end

  def test_is_sorted_and_number_of_pairs_that_prod_is_less_than_or_equal_to
    assert_equal 0, (1..9).to_a.is_sorted_and_number_of_pairs_that_prod_is_less_than_or_equal_to(1)
    assert_equal 1, (1..9).to_a.is_sorted_and_number_of_pairs_that_prod_is_less_than_or_equal_to(2) # 1 pairs: only 2 = 1 x 2
    assert_equal 6, (1..9).to_a.is_sorted_and_number_of_pairs_that_prod_is_less_than_or_equal_to(6)
    assert_equal 36, (1..9).to_a.is_sorted_and_number_of_pairs_that_prod_is_less_than_or_equal_to(81) # 36 pairs = 9 x 8 / 2
    assert_equal 36, (1..9).to_a.is_sorted_and_number_of_pairs_that_prod_is_less_than_or_equal_to(10_000)
    assert_equal 36, (-9..-1).to_a.reverse.is_sorted_and_number_of_pairs_that_prod_is_less_than_or_equal_to(81)
  end

  def test_lcm
    assert_equal 1, [].lcm
    assert_equal 1, [1].lcm
    assert_equal 6, [1, 2, 3].lcm
    assert_equal 6, [3, 2, 1].lcm
    assert_equal 3, [3, 3, 3].lcm
    assert_equal 12, [12, 6, 2].lcm
    assert_equal 72, [24, 36, 9].lcm
  end

  def test_lcm?
    assert_nil [].lcm?
    assert_equal 1, [1].lcm?
    assert_equal 6, [1, 2, 3].lcm?
    assert_equal 6, [3, 2, 1].lcm?
    assert_equal 3, [3, 3, 3].lcm?
    assert_equal 12, [12, 6, 2].lcm?
    assert_equal 72, [24, 36, 9].lcm?
  end

  def test_mean
    assert_raises(ArgumentError){ [].mean }
    assert_equal(1, [1].mean)
    assert_equal(2, [1, 2, 3].mean)
    assert_equal(2, [3, 2, 1].mean)
    assert_equal(3, [3, 3, 3].mean)
    assert_equal(6.666666666666667, [12, 6, 2].mean)
    assert_equal(23, [24, 36, 9].mean)
  end

  def test_med
    assert_raises(ArgumentError){ [].med }
    assert_equal(1, [1].med)
    assert_equal(2, [1, 2, 3].med)
    assert_equal(2, [3, 2, 1].med)
    assert_equal(3, [3, 3, 3].med)
    assert_equal(6, [12, 6, 2].med)
    assert_equal(24, [24, 36, 9].med)
    assert_equal(2.5, [1, 2, 3, 4].med)
    assert_equal(15.5, [15, 16].med)
    assert_equal(3, [1, 2, 3, 4, 5].med)
  end

  def test_mod
    assert_equal [], [].mod(10**9 + 7)
    assert_equal([1], [1].mod(10**9 + 7))
    assert_equal([1, 2, 3], [1, 2, 3].mod(10**9 + 7))
    assert_equal([3, 2, 1], [3, 2, 1].mod(10**9 + 7))
    assert_equal([3, 3, 3], [3, 3, 3].mod(10**9 + 7))
    assert_equal([12, 6, 2], [12, 6, 2].mod(10**9 + 7))
    assert_equal([0, 0, 1], [24, 36, 9].mod(2))
    assert_equal([1, 0, 1, 0], [1, 2, 3, 4].mod(2))
    assert_equal([0, 1], [15, 16].mod(3))
    assert_equal([1, 2, 0, 1, 2], [1, 2, 3, 4, 5].mod(3))
  end

  def test_modsum
    assert_equal 0, [].modsum(10**9 + 7)
    assert_equal(1, [1].modsum(10**9 + 7))
    assert_equal(6, [1, 2, 3].modsum(10**9 + 7))
    assert_equal(6, [3, 2, 1].modsum(10**9 + 7))
    assert_equal(9, [3, 3, 3].modsum(10**9 + 7))
    assert_equal(20, [12, 6, 2].modsum(10**9 + 7))
    assert_equal(1, [24, 36, 9].modsum(2))
    assert_equal(0, [1, 2, 3, 4].modsum(2))
    assert_equal(1, [15, 16].modsum(3))
    assert_equal(1, [15, 16].modsum(5))
    assert_equal(0, [1, 2, 3, 4, 5].modsum(3))
    assert_equal(3, [1, 2, 3, 4, 5].modsum(4))
  end

  def test_number_greater_than
    cfd = [1, 3, 3, 3, 4, 5, 5, 6].fd.reverse.cumsum.reverse
    assert_equal 8, cfd.number_greater_than(-100)
    assert_equal 8, cfd.number_greater_than(0)
    assert_equal 7, cfd.number_greater_than(1)
    assert_equal 4, cfd.number_greater_than(3)
    assert_equal 1, cfd.number_greater_than(5)
    assert_equal 0, cfd.number_greater_than(6)
    assert_equal 0, cfd.number_greater_than(100)
  end

  def test_prod
    assert_nil [].prod
    assert_equal 1, [1].prod
    assert_equal 6, [1, 2, 3].prod
    assert_equal 6, [3, 2, 1].prod
    assert_equal 27, [3, 3, 3].prod
    assert_equal 144, [12, 6, 2].prod
    assert_equal 24, [1, 2, 3, 4].prod
    assert_equal 120, [1, 2, 3, 4, 5].prod
  end

  def test_soko_age
    assert_equal [], [].soko_age(100)
    assert_equal [], [].soko_age(-100)
    assert_equal [50, 50, 50, 100], [0, 10, 20, 100].soko_age(50)
    assert_equal [20, 20, 20, 100], [-5, 3, 10, 100].soko_age(20)
    assert_equal [3, 3, 10, 100], [-5, 3, 10, 100].soko_age(3)
    assert_equal [3, 0, 0, 6], [3, -4, -5, 6].soko_age(0)
  end

  def test_test
  end

  def test_uniq?
    assert_equal(true, [].uniq?)
    assert_equal(true, [1].uniq?)
    assert_equal(true, [1, 2].uniq?)
    assert_equal(false, [1, 2, 1].uniq?)
    # assert_equal(true, [{a: 'a'}, {a: 'A'}].uniq?)
    # assert_equal(false, [{a: 'A'}, {a: 'A'}].uniq?)
    # assert_equal(true, @cls[1, 2, 3].uniq?)
  end
end

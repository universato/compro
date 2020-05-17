class Array
  include Comparable

  def abs; map{|k| k.abs } end
  def abs!; map!{|k| k.abs }; self end
  def cumgcd; res = self[0]; map{|t| res = t.gcd(res) } end
  def cumgcd(s=nil); s || (s = self[0]); map{|t| s = s.gcd(t) } end
  def cummax; res = -Float::INFINITY; map{|t| res > t ? res : res = t } end
  def cumsum; s = 0; map{|k| s += k } end
  def deru_kui(m); map{|t| t>m ? m : t } end
  def diff; (size-1).times.map { |i| self[i + 1] - self[i] } end
  def diff; (size-1).times.map { |i| self[i + 1] - self[i] }.to_a end
  # def diff; s = self[0]; self[1...(self.size)].map{|k|d=k-s; s=k; d} end
  # Frequency Distribution
  # 非負整数の度数分布を返す。0 ~ max(or 引数)の配列を返す。#tallyメソッドの配列版。
  def fd(n=nil); n = self.max if n.nil?; res = Array.new(n+1,0);self.map{|e| res[e]+=1 };res;end
  def gcd; inject(:gcd) end

  # Array#is_sorted_and_number_of_pairs_that_prod_is_less_than_or_equal_to
  # O(self.size)
  # required conditions:
  # only positive values and sorted in ascending order;[1, 2, 3, 4, 5]
  # or only negative values ans sorted in descending order;[-1, -2, -3, -4, -5]
  def is_sorted_and_number_of_pairs_that_prod_is_less_than_or_equal_to(x)
    res = 0
    l = 0
    r = self.size - 1
    while l < r
      r -= 1 while l < r && !(self[l] * self[r] <= x)
      res += r - l
      l += 1
    end
    res
  end

  def lcm; inject(:lcm) end
  def mean; inject(:+)*1.0/size end
  def med; n = size; s = sort; n.odd? ? s[n/2] : (s[n/2] + s[n/2-1]) / 2.0 end
  def mod(m); map{|e|e%m} end
  def modsum(m); reduce(0){|s,t| s+=t; s %= m if s >= m; s } end

  # fd.reverse.cumsum.reverseの返り値による配列(reverse累積度数分布)が使うメソッド
  def number_greater_than(x)
    return self[0] if x <= 0
    return 0  if size <= x+1
    self[x+1]
  end
  def prod; inject(:*) end
  def soko_age(m); map{|t| t<m ? m : t } end
  def uniq?
    return true if size <= 1
    s = sort
    x = s[-1]
    s.each do |a|
      return false if x == a
      x = a
    end
    return true
  end

end

require 'minitest/autorun'

class Array_Test < Minitest::Test
  def test_comparison_operator
    assert [] < [5]
    assert [] < ["a","b"]
    assert [1,2,3] < [3,4,5]
    assert [3,4,5] > [1,2,3]
    assert [1,1,1] == [1,1,1]
    assert [1,1] < [1,1,1]
    assert [1,2] > [1,1,1]
    assert [1,1] <= [1,1,1]
    assert [1,2] >= [1,1,1]
    assert ["a","b","c"] < ["a", "b", "d"]
    assert ["a","b","c"] < ["a", "b", "c", "d"]
  end
  def test_abs_method
    assert_equal [], [].abs
    assert_equal [1,2,3], [1,2,3].abs
    assert_equal [1], [-1].abs
    assert_equal [0,1,1], [0,-1,-1].abs
  end
  def test_abs!
    assert_equal [], [].abs!
    assert_equal [1,2,3], [1,2,3].abs!
    assert_equal [1], [-1].abs!
    assert_equal [0,1,1], [0,-1,-1].abs!
  end
  def test_cumgcd
    assert_equal([], [].cumgcd)
    assert_equal([1], [1].cumgcd)
    assert_equal([1,1,1], [1,2,3].cumgcd)
    assert_equal([3,1,1], [3,2,1].cumgcd)
    assert_equal([3,3,3], [3,3,3].cumgcd)
    assert_equal([12,6,2], [12,6,2].cumgcd)
    assert_equal([24,12,3], [24,36,9].cumgcd)
  end
  def test_cummax
    assert_equal([], [].cummax)
    assert_equal([1], [1].cummax)
    assert_equal([1,2,3], [1,2,3].cummax)
    assert_equal([3,3,3], [3,2,1].cummax)
    assert_equal([3,3,3], [3,3,3].cummax)
    assert_equal([12,12,12], [12,6,2].cummax)
    assert_equal([24,36,36], [24,36,9].cummax)
    assert_equal([-6,-2,10,10], [-6,-2,10,-5].cummax)
  end
  def test_cumsum
    assert_equal([], [].cumsum)
    assert_equal([1], [1].cumsum)
    assert_equal([1,3,6], [1,2,3].cumsum)
    assert_equal([3,5,6], [3,2,1].cumsum)
    assert_equal([3,6,9], [3,3,3].cumsum)
    assert_equal([12,18,20], [12,6,2].cumsum)
    assert_equal([24,60,69], [24,36,9].cumsum)
    assert_equal([-1,0,-1,0], [-1,1,-1,1].cumsum)
  end
  def test_deru_kui
    assert_equal [], [].deru_kui(100)
    assert_equal [], [].deru_kui(-100)
    assert_equal [0,10,20,50], [0,10,20,100].deru_kui(50)
    assert_equal [-5,3,10,20], [-5,3,10,100].deru_kui(20)
    assert_equal [-5,3,3,3], [-5,3,10,100].deru_kui(3)
    assert_equal [0,-4,-5,0], [3,-4,-5,6].deru_kui(0)
  end
  def test_diff
    assert_equal [], [].diff
    assert_equal [], [1].diff
    assert_equal [10,10,80], [0,10,20,100].diff
    assert_equal [8,7,90], [-5,3,10,100].diff
    assert_equal [-7,-1,11], [3,-4,-5,6].diff
  end
  def test_fd
    assert_equal [0]*6, [].fd(5)
    assert_equal [1]*6, [0, 1, 2, 3, 4, 5].fd
    assert_equal [0, 3], [1,1,1].fd
    assert_equal [0, 1, 0, 3, 1, 2], [5, 1, 4, 5, 3, 3, 3].fd
    n = rand(1..100)
    assert_equal [0]*(n+1), [].fd(n)
  end
  def test_gcd
    assert_nil [].gcd
    assert_equal(1, [1].gcd)
    assert_equal(1, [1,2,3].gcd)
    assert_equal(1, [3,2,1].gcd)
    assert_equal(3, [3,3,3].gcd)
    assert_equal(2, [12,6,2].gcd)
    assert_equal(3, [24,36,9].gcd)
  end
  def test_is_sorted_and_number_of_pairs_that_prod_is_less_than_or_equal_to
    assert_nil [].gcd
    assert_equal 0, (1..9).to_a.is_sorted_and_number_of_pairs_that_prod_is_less_than_or_equal_to(1)
    assert_equal 1, (1..9).to_a.is_sorted_and_number_of_pairs_that_prod_is_less_than_or_equal_to(2) # 1 pairs: only 2 = 1 x 2
    assert_equal 6, (1..9).to_a.is_sorted_and_number_of_pairs_that_prod_is_less_than_or_equal_to(6)
    assert_equal 36, (1..9).to_a.is_sorted_and_number_of_pairs_that_prod_is_less_than_or_equal_to(81) # 36 pairs = 9 x 8 / 2
    assert_equal 36, (1..9).to_a.is_sorted_and_number_of_pairs_that_prod_is_less_than_or_equal_to(10000)
    assert_equal 36, (-9..-1).to_a.reverse.is_sorted_and_number_of_pairs_that_prod_is_less_than_or_equal_to(81)
  end
  def test_lcm
    assert_nil [].lcm
    assert_equal(1, [1].lcm)
    assert_equal(6, [1,2,3].lcm)
    assert_equal(6, [3,2,1].lcm)
    assert_equal(3, [3,3,3].lcm)
    assert_equal(12, [12,6,2].lcm)
    assert_equal(72, [24,36,9].lcm)
  end
  def test_mean
    assert_nil [].lcm
    assert_equal(1, [1].mean)
    assert_equal(2, [1,2,3].mean)
    assert_equal(2, [3,2,1].mean)
    assert_equal(3, [3,3,3].mean)
    assert_equal(6.666666666666667, [12,6,2].mean)
    assert_equal(23, [24,36,9].mean)
  end
  def test_med
    # assert_nil [].med
    assert_equal(1, [1].med)
    assert_equal(2, [1,2,3].med)
    assert_equal(2, [3,2,1].med)
    assert_equal(3, [3,3,3].med)
    assert_equal(6, [12,6,2].med)
    assert_equal(24, [24,36,9].med)
    assert_equal(2.5, [1,2,3,4].med)
    assert_equal(15.5, [15,16].med)
    assert_equal(3, [1,2,3,4,5].med)
  end
  def test_mod
    assert_equal [], [].mod(10**9+7)
    assert_equal([1], [1].mod(10**9+7))
    assert_equal([1,2,3], [1,2,3].mod(10**9+7))
    assert_equal([3,2,1], [3,2,1].mod(10**9+7))
    assert_equal([3,3,3], [3,3,3].mod(10**9+7))
    assert_equal([12,6,2], [12,6,2].mod(10**9+7))
    assert_equal([0,0,1], [24,36,9].mod(2))
    assert_equal([1,0,1,0], [1,2,3,4].mod(2))
    assert_equal([0,1], [15,16].mod(3))
    assert_equal([1,2,0,1,2], [1,2,3,4,5].mod(3))
  end
  def test_modsum
    assert_equal 0, [].modsum(10**9+7)
    assert_equal(1, [1].modsum(10**9+7))
    assert_equal(6, [1,2,3].modsum(10**9+7))
    assert_equal(6, [3,2,1].modsum(10**9+7))
    assert_equal(9, [3,3,3].modsum(10**9+7))
    assert_equal(20, [12,6,2].modsum(10**9+7))
    assert_equal(1, [24,36,9].modsum(2))
    assert_equal(0, [1,2,3,4].modsum(2))
    assert_equal(1, [15,16].modsum(3))
    assert_equal(1, [15,16].modsum(5))
    assert_equal(0, [1,2,3,4,5].modsum(3))
    assert_equal(3, [1,2,3,4,5].modsum(4))
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
    assert_equal 6, [1,2,3].prod
    assert_equal 6, [3,2,1].prod
    assert_equal 27, [3,3,3].prod
    assert_equal 144, [12,6,2].prod
    assert_equal 24, [1,2,3,4].prod
    assert_equal 120, [1,2,3,4,5].prod
  end
  def test_soko_age
    assert_equal [], [].soko_age(100)
    assert_equal [], [].soko_age(-100)
    assert_equal [50,50,50,100], [0,10,20,100].soko_age(50)
    assert_equal [20,20,20,100], [-5,3,10,100].soko_age(20)
    assert_equal [3,3,10,100], [-5,3,10,100].soko_age(3)
    assert_equal [3,0,0,6], [3,-4,-5,6].soko_age(0)
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

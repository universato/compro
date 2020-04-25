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
  def gcd; inject(:gcd) end
  def lcm; inject(:lcm) end
  def mean; inject(:+)*1.0/size end
  def med; n = size; s = sort; n.odd? ? s[n/2] : (s[n/2] + s[n/2-1]) / 2.0 end
  def mod(m); map{|e|e%m} end
  def modsum(m); reduce(0){|s,t| s+=t; s %= m if s >= m; s } end
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
    assert [1,2,3] < [3,4,5]
    assert [3,4,5] > [1,2,3]
    assert [1,1,1] == [1,1,1]
    assert [1,1] < [1,1,1]
    assert [1,2] > [1,1,1]
    assert [1,1] <= [1,1,1]
    assert [1,2] >= [1,1,1]
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
  end
  def test_cumsum
    assert_equal([], [].cumsum)
    assert_equal([1], [1].cumsum)
    assert_equal([1,3,6], [1,2,3].cumsum)
    assert_equal([3,5,6], [3,2,1].cumsum)
    assert_equal([3,6,9], [3,3,3].cumsum)
    assert_equal([12,18,20], [12,6,2].cumsum)
    assert_equal([24,60,69], [24,36,9].cumsum)
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

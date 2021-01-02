class Array
  include Comparable

  def abs
    map(&:abs)
  end

  def abs!
    map!(&:abs)
    self
  end

  def cumgcd
    res = self[0]
    map{ |t| res = t.gcd(res) }
  end

  def cumgcd(s = nil)
    s || (s = self[0])
    map{ |t| s = s.gcd(t) }
  end

  def cummax
    res = -Float::INFINITY
    map{ |t| res > t ? res : res = t }
  end

  def cumsum
    s = 0
    map{ |k| s += k }
  end

  def deru_kui(m)
    map{ |t| t > m ? m : t }
  end

  def diff
    (size - 1).times.map { |i| self[i + 1] - self[i] }.to_a
  end

  # def diff; s = self[0]; self[1...(self.size)].map{|k|d=k-s; s=k; d} end
  # Frequency Distribution
  # 非負整数の度数分布を返す。0 ~ max(or 引数)の配列を返す。#tallyメソッドの配列版。
  def fd(n = nil)
    n = max if n.nil?
    res = Array.new(n + 1, 0)
    map{ |e| res[e] += 1 }
    res
  end

  def gcd
    inject(0, :gcd)
  end

  def gcd?
    inject(:gcd)
  end

  # Array#is_sorted_and_number_of_pairs_that_prod_is_less_than_or_equal_to
  # O(self.size)
  # required conditions:
  # only positive values and sorted in ascending order;[1, 2, 3, 4, 5]
  # or only negative values ans sorted in descending order;[-1, -2, -3, -4, -5]
  def is_sorted_and_number_of_pairs_that_prod_is_less_than_or_equal_to(x)
    res = 0
    l = 0
    r = size - 1
    while l < r
      r -= 1 while l < r && !(self[l] * self[r] <= x)
      res += r - l
      l += 1
    end
    res
  end

  def lcm
    inject(1, :lcm)
  end

  def lcm?
    inject(:lcm)
  end

  def mean
    raise ArgumentError if size == 0

    sum.fdiv(size)
  end

  def med
    raise ArgumentError if size == 0

    n = size
    s = sort
    n.odd? ? s[n / 2] : (s[n / 2] + s[n / 2 - 1]) / 2.0
  end

  def mod(m)
    map{ |e| e % m }
  end

  def modsum(m)
    reduce(0){ |s, t| s += t; s %= m if s >= m; s }
  end

  # fd.reverse.cumsum.reverseの返り値による配列(reverse累積度数分布)が使うメソッド
  def number_greater_than(x)
    return self[0] if x <= 0
    return 0  if size <= x + 1

    self[x + 1]
  end

  def prod
    inject(:*)
  end

  def soko_age(m)
    map{ |t| t < m ? m : t }
  end

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

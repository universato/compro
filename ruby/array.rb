class Array
  include Comparable

  class << self
    def infs(n, inf = Float::INFINITY)
      Array.new(n, inf)
    end

    def ones(n)
      Array.new(n, 1)
    end

    def zeros(n)
      Array.new(n, 0)
    end
  end

  def abs
    map(&:abs)
  end

  def abs!
    map!(&:abs)
    self
  end

  def cumgcd
    s = 0
    map{ |k| s = s.gcd(k) }
  end

  def cummax
    m = self[0]
    map{ |t| m > t ? m : m = t }
  end

  def cummin
    m = self[0]
    map{ |t| m < t ? m : m = t }
  end

  def cumsum
    s = 0
    map{ |k| s += k }
  end

  def dot(other)
    zip(other).sum{ |x, y| x * y }
  end

  def times(other)
    zip(other).map{ |x, y| x * y }
  end

  def deru_kui(m)
    map{ |t| t > m ? m : t }
  end

  def diff
    (size - 1).times.map { |i| self[i + 1] - self[i] }.to_a
  end

  # 上より高速かも
  def diff
    t = 0
    res = map{ |x| x, t = t, x; t - x }
    res.shift
    res
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

  # https://yukicoder.me/problems/no/1366
  def kadomatsu?
    return nil unless size == 3
    return false unless uniq.size == 3

    self[1] == min || self[1] == max
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

  def slices(n)
    each_slice.map(n)
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
    true
  end

  def test(other)
    n = size
    if size == other.size
      puts "sizeは一致しました n: #{n}個です"
    elsif size < other.size
      puts "otherの方がサイズが大きいです。"
    else
      puts "otherのサイズが小さいです(注)"
      n = other.size
    end

    diff_zero_cnt = 0
    diff_pozi_cnt = 0
    res = ""
    n.times do |i|
      if self[i] == other[i]
        diff_zero_cnt += 1
        next
      else
        o = other[i]
        s = self[i]
        d = other[i] - self[i]
        res << "#{i}: #{s} #{o} #{d}\n"
        diff_pozi_cnt += 1 if d > 0
      end
    end

    puts "#{n}個中、#{diff_zero_cnt}個一致しました。#{diff_pozi_cnt}個、otherが大きいです"
    puts res
  end
end

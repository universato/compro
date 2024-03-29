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

  def rcumgcd
    reverse.cumgcd.reverse
  end

  def cummax
    m = self[0]
    map{ |t| m > t ? m : m = t }
  end

  def rcummax
    reverse.cummax.reverse
  end

  def cummin
    m = self[0]
    map{ |t| m < t ? m : m = t }
  end

  def rcummin
    reverse.cummin.reverse
  end

  def cumsum
    s = 0
    map{ |k| s += k }
  end

  # (1..4).to_a.rcumsum # => [10, 9, 7, 4]
  def rcumsum
    reverse.cumsum.reverse
  end

  def cumsum2d
    h = size
    w = self[0].size
    res = Array.new(h){ [0] * w }
    s = 0; first_row = self[0].map{ |k| s += k }; res[0] = first_row;
    s = 0; (1...h).each{ |i| res[i][0] = self[i][0] + res[i - 1][0] }
    (1...h).each do |i|
      (1...w).each do |j|
        res[i][j] = self[i][j] + res[i][j - 1] + res[i - 1][j] - res[i - 1][j - 1]
      end
    end
    res
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
    t = 0
    map{ |x| x, t = t, x; t - x  }.drop(1)
  end

  def diff1(other)
    sz = size
    (0...sz).map{ |i| self[i] - other[i] }
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

  # for Graph
  # [[1, 2], [1, 3]].to_adjacency_list #= => {1 => [2, 3], 2 => [1], 3 => [1]}
  def to_adjacency_hash
    res = Hash.new{ [] }
    each do |x, y|
      res[x] << y
      res[y] << x
    end
    res
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

class Array
  def squeeze2
    res = []
    prev = nil
    renzoku = true
    each do |e|
      if e == prev && renzoku
        renzoku = !renzoku
        next
      end
      prev = e
      res << e
      renzoku = true
    end
    res
  end
end

# 2次元配列(行列の形)の周りに破壊的に壁を作る。
# levelが壁を何重にするか。デフォルトは1.
# https://atcoder.jp/contests/abc176/submissions/23195501 1618ms <- 1607ms 特に遅くならなかった。
# 囲いの壁を破壊しないというのもある。
class Array
  def build_walls(wall = -1, level = 1)
    h = self.size
    w = self[0].size
    left_side = [wall] * level
    right_side = left_side.dup
    map!{ |r| left_side + r + right_side }
    row = [wall] * (w + level * 2)
    level.times{ prepend(row) }
    level.times{ push(row) }
  end
end

if __FILE__ == $0
  a = [1, 1, 1, 2, 2, 1, 1, 1, 2, 2, 2, 1, 1, 1, 1, 2, 2, 2, 2]
  p a.squeeze2
end

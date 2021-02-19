# Fenwick Tree or BIT(BinaryIndexedTree)
class BinaryIndexedTree
  attr_accessor :bit

  def initialize(n)
    @n    = n
    @bit  = Array.new(n + 1, 0)
  end

  # i : 1-indexed
  def sum(i)
    res = 0
    while i > 0
      res += @bit[i]
      i -= (i & -i)
    end
    res
  end

  def add(i, x)
    while i <= @n
      @bit[i] += x
      i += (i & -i)
    end
  end

  # ARC033
  # i番目に小さい数値(1-based index)
  # https://atcoder.jp/contests/arc033/submissions/5714405
  def n_th(i)
    res = 0
    rx = i
    k = 1 << @n.bit_length - 1
    while k > 0
      if res + k <= @n && @bit[res + k] < rx
        rx -= @bit[res + k]
        res += k
      end
      k >>= 1
    end
    res += 1
  end
end

# ARC033
X_MAX = 200_000
b = BinaryIndexedTree.new(X_MAX)

m_a = X_MAX
m_b = 1
q = gets.to_s.to_i
$<.read.split.map(&:to_i).each_slice(2) do |t, x|
  if t == 1
    b.add(x, 1)
    m_a = x if m_a > x
    m_b = x if m_b < x
  else
    puts ans = b.n_th(x)
    b.add(ans, -1)
  end
end

# n = 4
# a = [3, 1, 4, 2]

# n = gets.to_s.to_i
# a = gets.to_s.split.map{|t| t.to_i }

# n = 4
# a = [3, 1, 4, 2]

# 蟻本
# b = BinaryIndexedTree.new(n)
# ans = 0
# n.times do |j|
#   ans += j - b.sum(a[j])
#   b.add(a[j], 1)
# end
# puts ans

# POJ 3468
# n, q = gets.to_s.split.map{|t| t.to_i }
# a    = [0] + gets.to_s.split.map{|t| t.to_i }

# b0 = BinaryIndexedTree.new(n)
# b1 = BinaryIndexedTree.new(n)

# 1.upto(n) do |i|
#   b0.add(i, a[i])
# end

# q.times do |i|

#   t, *tmp = gets.to_s.split
#   tmp.map!{|t| t.to_i }
#   if t == 'C'
#     l, r, x = tmp
#     b0.add( l,     -x * (l - 1) )
#     b1.add( l,      x              )
#     b0.add( r + 1,  x * r       )
#     b1.add( r + 1, -x              )
#   else
#     l, r = tmp
#     ans = 0
#     ans += b0.sum(r) + b1.sum(r) * r
#     ans -= b0.sum(l-1) + b1.sum(l-1) * (l-1)
#     puts ans
#   end
# end

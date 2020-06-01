# 0-indexedで、getは半開区間であることに注意
class SegmentTree

  # O(n)
  # and :2^1-1
  # gcd :    0
  # max : -inf
  # min :  inf
  # or  :    0
  # prod:    1
  # set :   []
  # sum :    0
  def initialize(n, identity_element)
    @identity_element = identity_element
    @n = 1
    @n *= 2 while @n < n
    # @n: leaf node size(2^k)
    # @n*2-1: tree node size
    @nodes = Array.new(@n*2-1){ @identity_element }
  end

  def update_gcd(i, val)
    # @n-1: inner node size
    i += @n - 1
    @nodes[i] = val
    while i > 0
      i = ( i - 1 ) / 2
      @nodes[i] = @nodes[2*i+1].gcd @nodes[2*i+2]
    end
  end

  def update_min(i, val)
    # @n-1: inner node size

    i += @n - 1
    # p [i]
    @nodes[i] = val
    while i > 0
      i = ( i - 1 ) / 2
      @nodes[i] = [@nodes[2*i+1], @nodes[2*i+2]].min
    end
  end

  def update_or(i, val)
    # @n-1: inner node size
    i += @n - 1
    @nodes[i] = val
    while i > 0
      i = ( i - 1 ) / 2
      @nodes[i] = @nodes[2*i+1] | @nodes[2*i+2]
    end
  end

  def update_set(i, val)
    # @n-1: inner node size
    i += @n - 1
    @nodes[i] = val
    while i > 0
      i = ( i - 1 ) / 2
      @nodes[i] = @nodes[2*i+1] + @nodes[2*i+2]
    end
  end

  def update_sum(i, val)
    # @n-1: inner node size
    i += @n - 1
    @nodes[i] = val
    while i > 0
      i = ( i - 1 ) / 2
      @nodes[i] = @nodes[2*i+1] + @nodes[2*i+2]
    end
  end

  def swap_min(i, j)
    # @n-1: inner node size
    n_i = @nodes[i + @n-1].dup
    n_j = @nodes[j + @n-1].dup
    n_i[-1] = j
    n_j[-1] = i
    update_min(i, n_j)
    update_min(j, n_i)
  end

  def get_gcd(l, r)
    l += @n - 1
    r += @n - 1
    lres, rres = @identity_element, @identity_element
    while l < r
      if l[0] == 0
        lres = lres.gcd @nodes[l]
        l += 1
      end
      if r[0] == 0
        r -= 1
        rres = (@nodes[r]).gcd rres
      end
      l /= 2
      r /= 2
    end
    return lres.gcd(rres)
  end

  def get_min(l, r)
    l += @n - 1
    r += @n - 1
    lres, rres = @identity_element, @identity_element
    while l < r
      if l[0] == 0
        lres = @nodes[l] if lres > @nodes[l]
        l += 1
      end
      if r[0] == 0
        r -= 1
        rres = @nodes[r] if rres > @nodes[r]
      end
      l /= 2
      r /= 2
    end
    return lres < rres ? lres : rres
  end

  def get_or(l, r)
    l += @n - 1
    r += @n - 1
    lres, rres = @identity_element, @identity_element
    while l < r
      if l[0] == 0
        lres |= @nodes[l]
        l += 1
      end
      if r[0] == 0
        r -= 1
        rres |= @nodes[r]
      end
      l /= 2
      r /= 2
    end
    return lres | rres
  end

  def get_sum(l, r)
    l += @n - 1
    r += @n - 1
    lres, rres = @identity_element, @identity_element
    while l < r
      if l[0] == 0
        lres += @nodes[l]
        l += 1
      end
      if r[0] == 0
        r -= 1
        rres += @nodes[r]
      end
      l /= 2
      r /= 2
    end
    return lres + rres
  end

  def inspect

    t = 0
    res = "SegmentTree\n  "
    @nodes.each_with_index do |e,i|

      res << e.to_s << " "
      if t == i && i < @n-1
        res << "\n  "
        t = t * 2 + 2
      end
    end
    res
  end
end

class Array
  include Comparable
  def to_st(identity_element)
    st = SegmentTree.new(size, identity_element)
    each_with_index{ |t, i| st.update_min(i, t) }
    st
  end
end

n, q = gets.to_s.split.map{|t| t.to_i }
a    = gets.to_s.split.map{|t| t.to_i }

inf = [n + 1, nil]
# st = SegmentTree.new(n, inf)
st = a.map.with_index{|t, i| [t, i] }.to_st(inf)

q.times do
  x, l, r = gets.to_s.split.map{|t| t.to_i - 1 }
  # p "aaa"
  if x == 0
    st.swap_min(l, r)
  else
    # puts "ans:"
    p st.get_min(l, r+1)[-1] + 1
  end
end

puts ""

# ABC 157
n = gets.to_s.to_i
s = gets.to_s.chomp
q = gets.to_s.to_i

st = SegmentTree.new(n, 0)

# p "a".ord #=> 97
s.bytes.each_with_index do |c, i|
  st.update_or(i, 1 << (c-97))
end

q.times do

  t, x, y = gets.to_s.split

  if t == "1"
    i, c = x.to_i-1, y[0].ord
    st.update_or(i, 1 << (c-97))
  else
    l, r = x.to_i-1, y.to_i-1
    puts st.get_or(l, r+1).to_s(2).count('1')
  end
end

#
# n = gets.to_s.to_i
# s = gets.to_s.chomp
# q = gets.to_s.to_i

# # sts = Array.new(26){ SegmentTree.new(n, form: :sum) }
# st = SegmentTree.new(n, form: :set)
# # p st
# # p "a".ord #=> 97
# s.chars.each_with_index do |c, i|
#   # sts[c - 97].update_sum(i, c)
#   st.update_sum(i, Set[c])
# end
# # p st
# q.times do

#   t, x, y = gets.to_s.split

#   if t == '1'
#     i, c = x.to_i-1, y.ord
#     st.update_sum(i, Set[y])
#   else
#     l, r = x.to_i-1, y.to_i-1
#     # p st
#     puts st.get_sum(l, r+1).size
#   end
# end

#  ABC125 C - GCD on Blackboard
# n = gets.to_s.to_i
# a = gets.to_s.split.map{|t| t.to_i }

# st = a.to_st(:gcd)
# ans = [st.get_gcd(1, n), st.get_gcd(0, n-1)].max

# 1.upto(n-2) do |i|
#   v = st.get_gcd(0, i).gcd st.get_gcd(i+1, n)
#   ans = v if ans < v
# end

# puts ans

# DSL_2_A
# 蟻本　python セグメント木　競技プログラミング　Atcoder - じゅっぴーダイアリー
# https://juppy.hatenablog.com/entry/2019/05/02/%E8%9F%BB%E6%9C%AC_python_%E3%82%BB%E3%82%B0%E3%83%A1%E3%83%B3%E3%83%88%E6%9C%A8_%E7%AB%B6%E6%8A%80%E3%83%97%E3%83%AD%E3%82%B0%E3%83%A9%E3%83%9F%E3%83%B3%E3%82%B0_Atcoder

# DSL_2_A
# n, q = gets.to_s.split.map{|t|t.to_i}
# st = SegmentTree.new(n)

# q.times do

#   c, x, y = gets.to_s.split
#   c, x, y = c.to_i, x.to_i, y.to_i

#   if c.zero?
#     st.update_min(x, y)
#   else
#     puts st.get_min(x, y+1)
#   end
# end

require 'minitest/autorun'

class SegmentTree_Test < Minitest::Test
  def test_get_min
    n = 3
    inf = Float::INFINITY
    st = SegmentTree.new(n, inf)
    # assert_equal 2**31-1, st.inf
    st.update_min(0, 1)
    st.update_min(1, 2)
    st.update_min(2, 3)
    assert_equal 1, st.get_min(0,2)
    assert_equal 2, st.get_min(1,2)
  end
  # def test_get_min
  #   st = [7,6,8].to_st
  #   # st.update_gcd(0, 1)
  #   # st.update(1, 2)
  #   # st.update(2, 3)
  #   assert_equal 7, st.get_gcd(0,1)
  #   assert_equal 2, st.get_gcd(1,3)
  # end
end

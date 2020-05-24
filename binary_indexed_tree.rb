class BinaryIndexedTree

  attr_accessor :bit

  def initialize(n)
    @n    = n
    @bit  = Array.new(n+1){ 0 }
    # @bit1 = Array.new(n+1){ 0 }
  end

  # i : 1-indexed
  def sum(i)
    res = 0
    while i > 0
      res += @bit[i]
      i -= ( i & -i )
    end
    res
  end

  def add(i, x)
    while i <= @n
      # p [i, x, @bit[i]]
      @bit[i] += x
      i += ( i & -i )
      # p i
    end
  end
end

# n = gets.to_s.to_i
# a = gets.to_s.split.map{|t| t.to_i }

# n = 4
# a = [3, 1, 4, 2]

#蟻本
# b = BinaryIndexedTree.new(n)
# ans = 0
# n.times do |j|
#   ans += j - b.sum(a[j])
#   b.add(a[j], 1)
# end
# puts ans


#POJ 3468
n, q = gets.to_s.split.map{|t| t.to_i }
a    = [0] + gets.to_s.split.map{|t| t.to_i }

b0 = BinaryIndexedTree.new(n)
b1 = BinaryIndexedTree.new(n)
# p b0
1.upto(n) do |i|
  b0.add(i, a[i])
end
# p b0

q.times do |i|

  t, *tmp = gets.to_s.split
  tmp.map!{|t| t.to_i }
  if t == 'C'
    l, r, x = tmp
    b0.add( l,     -x * (l - 1) )
    b1.add( l,      x              )
    b0.add( r + 1,  x * r       )
    b1.add( r + 1, -x              )
  else
    l, r = tmp
    ans = 0
    ans += b0.sum(r) + b1.sum(r) * r
    ans -= b0.sum(l-1) + b1.sum(l-1) * (l-1)
    puts ans
  end

  # if t[i] == 'C'
  #   b0.add( l[i],     -x[i] * (l[i] - 1) )
  #   b1.add( l[i],      x[i]              )
  #   b0.add( r[i] + 1,  x[i] * r[i]       )
  #   b1.add( r[i] + 1, -x[i]              )
  # else
  #   ans = 0
  #   ans += b0.sum(r[i]) + b1.sum(r[i]) * r[i]
  #   ans -= b0.sum(l[i]-1) + b1.sum(l[i]-1) * (l[i]-1)
  # end
end

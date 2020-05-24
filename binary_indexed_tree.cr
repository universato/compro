class BinaryIndexedTree

  @n : Int32
  @bit : Array(Int64)

  def initialize(n)
    @n    = n
    @bit  = Array.new(n+1){ 0_i64 }
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

  # i : 1-indexed
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

n = 4
a = [3, 1, 4, 2]

#蟻本
b = BinaryIndexedTree.new(n)
ans = 0
n.times do |j|
  ans += j - b.sum(a[j])
  b.add(a[j], 1)
end
puts ans


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

  tmp = gets.to_s.split
  if tmp[0] == "C"
    l, r, x = tmp[1,3].map{|t|t.to_i}
    b0.add( l,     -x * (l - 1) )
    b1.add( l,      x              )
    b0.add( r + 1,  x * r       )
    b1.add( r + 1, -x              )
  else
    l, r = tmp[1,2].map{|t|t.to_i}
    ans = 0
    ans += b0.sum(r) + b1.sum(r) * r
    ans -= b0.sum(l-1) + b1.sum(l-1) * (l-1)
    puts ans
  end
end

# See fenwick_tree.cr
# あとから作ったfenwick_tree.crの方が完成度が高いはず。
# これは1-based index。あっちは、0-based index.
class BinaryIndexedTree
  @n : Int32
  @bit : Array(Int64)

  def initialize(n)
    @n    = n
    @bit  = Array.new(n+1, 0_i64)
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
    end
  end
end

# n = gets.to_s.to_i
# a = gets.to_s.split.map{ |t| t.to_i }

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

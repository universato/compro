# Fenwick Tree
class FenwickTree
  attr_reader :data, :size

  def initialize(arg = 0)
    case arg
    when Array
      @size = arg.size
      @data = [0].concat(arg)
      (1 ... @size).each do |i|
        up = i + (i & -i)
        next if up > @size

        @data[up] += @data[i]
      end
    when Integer
      @size = arg
      @data = Array.new(@size + 1, 0)
    else
      raise ArgumentError
    end
  end

  def add(i, x)
    i += 1
    while i <= @size
      @data[i] += x
      i += (i & -i)
    end
  end

  def sum(l, r)
    _sum(r) - _sum(l)
  end

  def _sum(i)
    res = 0
    while i > 0
      res += @data[i]
      i &= i - 1
    end
    res
  end
end

FeTree            = FenwickTree
Fetree            = FenwickTree
BinaryIndexedTree = FenwickTree

# 転倒数
def inversion_number(a)
  n = a.size
  ft = FenwickTree.new(n)
  res = (n - 1) * n / 2
  a.each do |k|
    res -= ft._sum(k)
    ft.add(k, 1)
  end
  res
end

# [n - 1, n - 2, …… , 1, 0]の転倒数が、(n - 1) * n / 2

# [1, 2, 3, 0] (n - 1) * n / 2 => 6   # 転倒数:3
# [0, 0, 0, 0] ft._sum(1) #=> 0 0 - 0 = 0
# [0, 1, 0, 0] ft._sum(2) #=> 1 1 - 1 = 0 新しく出来るペア数 - 新しくできる非転倒数。
# [0, 1, 1, 0] ft._sum(3) #=> 2 2 - 2 = 0 転倒してなければ、今までの数字をカバーしてるはず。
# [0, 1, 1, 1] ft._sum(0) #=> 0 3 - 0 = 3

# [2, 3, 0, 1] (n - 1) * n / 2 => 6   # 転倒数:4
# [0, 0, 0, 0] ft._sum(2) #=> 0 0 - 0 = 0
# [0, 0, 1, 0] ft._sum(3) #=> 1 1 - 1 = 0
# [0, 0, 1, 1] ft._sum(0) #=> 0 2 - 0 = 2
# [1, 0, 1, 1] ft._sum(1) #=> 1 3 - 1 = 2

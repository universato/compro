# https://github.com/universato/ac-library-rb/blob/master/lib/fenwick_tree.rb
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

  def [](idx)
    _sum(idx + 1) - _sum(idx)
  end

  #  sum(r)      # [0, r)
  #  sum(l, r)   # [l, r)
  #  sum(l...r)  # [l, r)
  #  sum(l..r)   # [l, r]
  def sum(a, b = nil)
    if b
      _sum(b) - _sum(a)
    elsif a.is_a?(Range)
      l = a.begin
      r = a.exclude_end? ? a.end : a.end + 1
      _sum(r) - _sum(l)
    else
      _sum(a)
    end
  end

  # [0, i)
  def _sum(i)
    res = 0
    while i > 0
      res += @data[i]
      i &= i - 1
    end
    res
  end
  alias left_sum _sum
end

FeTree            = FenwickTree
Fetree            = FenwickTree
BinaryIndexedTree = FenwickTree

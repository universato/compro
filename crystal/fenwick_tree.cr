class FenwickTree(T)
  getter size : Int32
  getter data : Array(T)

  def initialize(@size : Int32)
    @data = Array(T).new(@size + 1, T.zero)
  end

  def initialize(@data : Array(T))
    @size = @data.size
    @data = Array(T).new(1, T.zero).concat(@data)
    (1 ... @size).each do |i|
      up = i + (i & -i)
      next if up > @size

      @data[up] += @data[i]
    end
  end

  def add(i : Int, x : T)
    i += 1
    while i <= @size
      @data[i] += x
      i += (i & -i)
    end
  end

  def sum(l : Int, r : Int)
    sum(r) - sum(l)
  end

  def sum(i : Int)
    res = T.zero
    while i > 0
      res += @data[i]
      i &= i - 1
    end
    res
  end
end

class SegmentTree

  @@inf = 2**31-1

  def initialize(n)
    @n = 1
    @n *= 2 while @n < n
    @nodes = Array.new(@n*2-1, @@inf)
  end

  def update(i, val)
    i += @n - 1
    @nodes[i] = val
    while i > 0
      i = ( i - 1 ) / 2
      @nodes[i] = [@nodes[2*i+1], @nodes[2*i+2]].min
    end
  end

  def getmin(a, b, k=0, l=0, r=-1)

    r = @n if r < 0
    return @@inf if (r <= a || b <= l)
    return @nodes[k] if (a <= l && r <= b)

    vl = getmin(a, b, k*2+1, l, (l+r)/2)
    vr = getmin(a, b, k*2+2, (l+r)/2,r)
    return vl <= vr ? vl : vr
  end

  def inspect

    t = 0
    res = "SegmentTrree\n  "
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

n, q = gets.to_s.split.map{|t|t.to_i}
st = SegmentTree.new(n)
p st
q.times do

  c, x, y = gets.to_s.split
  c, x, y = c.to_i, x.to_i, y.to_i

  if c.zero?
    st.update(x, y)
    p st
  else
    puts st.getmin(x, y+1)
  end
end

# p 0.0.zero?
# p 1.next
# p 1.succ
# p 1.pred #=> 1

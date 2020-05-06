class SegmentTree

  @@inf = 2**31-1

  def initialize(n)
    @n = 1
    @n *= 2 while @n < n
    # @n: leaf node size(2^k)
    # @n*2-1: tree node size
    @nodes = Array.new(@n*2-1, @@inf)
    @lazys = Array.new(@n*2-1, @@inf)
  end

  # def update(i, val)
  #   # @n-1: inner node size
  #   i += @n - 1
  #   @nodes[i] = val
  #   while i > 0
  #     i = ( i - 1 ) / 2
  #     @nodes[i] = [@nodes[2*i+1], @nodes[2*i+2]].min
  #   end
  # end

  def update(a,b,val,k=0,l=0,r=@n)
    # p @nodes
    eval(k)
    if a <= l && r <= b
      @lazys[k] = val
      eval(k)
    elsif a < r && l < b
      update(a, b, val, k*2+1,l,(l+r)/2)
      update(a, b, val, k*2+2,(l+r)/2,r)
      #p @nodes
      @nodes[k] = [@nodes[k*2+1], @nodes[k*2+2]].min
    end
  end

  def eval(k)
    return if @lazys[k] == @@inf
    if k < @n - 1
      @lazys[k*2+1] = @lazys[k]
      @lazys[k*2+2] = @lazys[k]
    end
    @nodes[k] = @lazys[k]
    @lazys[k] = @@inf
  end

  def getmin(a, b, k=0, l=0, r=-1)

    eval(k)

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

# DSL_2_A
# 蟻本　python セグメント木　競技プログラミング　Atcoder - じゅっぴーダイアリー
# https://juppy.hatenablog.com/entry/2019/05/02/%E8%9F%BB%E6%9C%AC_python_%E3%82%BB%E3%82%B0%E3%83%A1%E3%83%B3%E3%83%88%E6%9C%A8_%E7%AB%B6%E6%8A%80%E3%83%97%E3%83%AD%E3%82%B0%E3%83%A9%E3%83%9F%E3%83%B3%E3%82%B0_Atcoder

n, q = gets.to_s.split.map{|t|t.to_i}
st = SegmentTree.new(n)
# p st
q.times do

  c, x, y = gets.to_s.split
  c, x, y = c.to_i, x.to_i, y.to_i

  if c.zero?
    st.update(x, x+1, y)
    # p st
  else
    puts st.getmin(x, y+1)
  end
end

# p 0.0.zero?
# p 1.next
# p 1.succ
# p 1.pred #=> 1

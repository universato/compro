class SegmentTree(T)
  @n : (Int64|Int32)
  @nodes : Array(Set(T))

  def initialize(n)
    @n = 1
    while @n < n
      @n *= 2
    end

    @nodes = Array(Set(T)).new(@n*2-1){ Set(T).new }
  end

  def update_set(i, val)
    i += @n - 1
    @nodes[i] = val
    while i > 0
      i = ( i - 1 ) >> 1
      @nodes[i] = @nodes[2*i+1] | @nodes[2*i+2]
    end
  end

  def get_set(l, r)
    l += @n - 1
    r += @n - 1
    lres, rres = Set(T).new(), Set(T).new()
    while l < r
      if 0 == ( l & 1 )
        lres = lres | @nodes[l]
        l += 1
      end
      if 0 == ( r & 1 )
        r -= 1
        rres = rres | @nodes[r]
      end
      l /= 2
      r /= 2
    end
    return lres | rres
  end
end

n = gets.to_s.to_i64
s = gets.to_s.chomp
q = gets.to_s.to_i

# sts = Array.new(26){ SegmentTree.new(n, form: :sum) }
st = SegmentTree(UInt8).new(n)
# p st
# p "a".ord #=> 97
s.bytes.each_with_index do |c, i|
  # sts[c - 97].update_sum(i, c)
st.update_set(i, Set.new([c]))
end
#p st
q.times do

  t, x, y = gets.to_s.split

  if t == "1"
    #p y[0]
    i, c = x.to_i64-1, y.bytes
st.update_set(i, Set.new(c))
  else
    l, r = x.to_i-1, y.to_i-1
    # p st
    puts st.get_set(l, r+1).size
  end
end

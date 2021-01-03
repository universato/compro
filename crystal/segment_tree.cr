class SegmentTree
  @n : (Int64|Int32)
  @nodes : Array(Int64)
  @identity_element : Int64

  def initialize(n, identity_element)
    # or  :    0
    # min :  inf
    # max : -inf
    # set :   []
    # sum :    0
    # prod:    1
    # gcd :    0
    @identity_element = identity_element

    @n = 1
    while @n < n
      @n *= 2
    end

    @nodes = Array(Int64).new(@n*2-1, @identity_element)
  end

  def update_or(i, val)
    i += @n - 1
    @nodes[i] = val
    while i > 0
      i = ( i - 1 ) >> 1
      @nodes[i] = @nodes[2*i+1] | @nodes[2*i+2]
    end
  end

  def update_sum(i, val)
    i += @n - 1
    @nodes[i] = val
    while i > 0
      i = ( i - 1 ) >> 1
      @nodes[i] = @nodes[2*i+1] + @nodes[2*i+2]
    end
  end

  def update_gcd(i, val)
    i += @n - 1
    @nodes[i] = val
    while i > 0
      i = ( i - 1 ) >> 1
      @nodes[i] = @nodes[2*i+1].gcd @nodes[2*i+2]
    end
  end

  def get_or(l, r)
    l += @n - 1
    r += @n - 1
    lres, rres = @identity_element, @identity_element
    while l < r
      if 0 == ( l & 1 )
        lres |= @nodes[l]
        l += 1
      end
      if 0 == ( r & 1 )
        r -= 1
        rres |= @nodes[r]
      end
      l /= 2
      r /= 2
    end
    return lres | rres
  end

  def get_gcd(l, r)
    l += @n - 1
    r += @n - 1
    lres, rres = @identity_element, @identity_element
    while l < r
      if 0 == ( l & 1 )
        lres = lres.gcd @nodes[l]
        l += 1
      end
      if 0 == ( r & 1 )
        r -= 1
        rres = (@nodes[r]).gcd rres
      end
      l /= 2
      r /= 2
    end
    return lres.gcd rres
  end

  def get_sum(l, r)
    l += @n - 1
    r += @n - 1
    lres, rres = @identity_element, @identity_element
    while l < r
      if 0 == ( l & 1 )
        lres = lres + @nodes[l]
        l += 1
      end
      if 0 == ( r & 1 )
        r -= 1
        rres = rres + @nodes[r]
      end
      l /= 2
      r /= 2
    end
    return lres + rres
  end
end

class Array
  def to_segment_tree_for_gcd
    st = SegmentTree.new(size.to_i64, 0_i64)
    each_with_index{ |t, i| st.update_gcd(i, t) }
    st
  end
  def to_segment_tree_for_sum
    st = SegmentTree.new(size, 0_i64)
    each_with_index{ |t, i| st.update_sum(i, t) }
    st
  end
end

#
n = gets.to_s.to_i64
s = gets.to_s.chomp
q = gets.to_s.to_i

# sts = Array.new(26){ SegmentTree.new(n, form: :sum) }
st = SegmentTree.new(n, 0i64)
# p st
# p "a".ord #=> 97
s.bytes.each_with_index do |c, i|
  # sts[c - 97].update_sum(i, c)
  st.update_or(i, 1i64 << (c-97))
end

q.times do

  t, x, y = gets.to_s.split

  if t == "1"
    #p y[0]
    i, c = x.to_i64-1, y[0].ord
    st.update_or(i, 1i64 << (c-97))
  else
    l, r = x.to_i-1, y.to_i-1
    # p st
    puts st.get_or(l, r+1).popcount
  end
end

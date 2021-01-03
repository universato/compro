# これはセグメントツリー内に数値とインデックスをもたせてるけど、遅いのでよくない。
# インデックスは別管理した方が良い。
class SegmentTree
  @n : (Int64|Int32)
  @nodes : Array(Array(Int32))
  @identity_element : Array(Int32)

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

    @nodes = Array.new(@n*2-1){@identity_element}
  end

  def update_min(i, val)
    i += @n - 1
    @nodes[i] = val
    while i > 0
      i = ( i - 1 ) >> 1
     @nodes[i] = {@nodes[2*i+1], @nodes[2*i+2]}.min
    end
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
      l //= 2
      r //= 2
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
      l //= 2
      r //= 2
    end
    return lres.gcd rres
  end

  def get_min(l, r)
    l += @n - 1
    r += @n - 1
    lres, rres = @identity_element, @identity_element
    while l < r
      if 0 == ( l & 1 )
        lres = {lres, @nodes[l]}.min
        l += 1
      end
      if 0 == ( r & 1 )
        r -= 1
        rres = {@nodes[r], rres}.min
      end
      l //= 2
      r //= 2
    end
    return {lres, rres}.min
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
      l //= 2
      r //= 2
    end
    return lres + rres
  end

  def swap_min(i, j)
    # @n-1: inner node size
    n_i = @nodes[i + @n-1].dup
    n_j = @nodes[j + @n-1].dup
    n_i[-1] = j
    n_j[-1] = i
    update_min(i, n_j)
    update_min(j, n_i)
  end
end

class Array
  def to_segment_tree_for_gcd
    st = SegmentTree.new(size.to_i64, 0_i64)
    each_with_index{ |t, i| st.update_gcd(i, t) }
    st
  end
  def to_segment_tree_for_min(inf = 10 ** 12)
    st = SegmentTree.new(size, inf)
    each_with_index{ |t, i| st.update_min(i, t) }
    st
  end
  def to_segment_tree_for_sum
    st = SegmentTree.new(size, 0_i64)
    each_with_index{ |t, i| st.update_sum(i, t) }
    st
  end
end

def yukicoder875
  # yukicoder No.875 Range Mindex Query
  n, q = gets.to_s.split.map{|t| t.to_i }
  a    = gets.to_s.split.map{|t| t.to_i }

  inf = [n + 1, 0]
  # st = SegmentTree.new(n, inf)
  st = a.map_with_index{|t, i| [t, i] }.to_segment_tree_for_min(inf)

  q.times do
    x, l, r = gets.to_s.split.map{|t| t.to_i - 1 }
    # p "aaa"
    if x == 0
      st.swap_min(l, r)
    else
      # puts "ans:"
      p st.get_min(l, r+1)[-1] + 1
    end
  end
end

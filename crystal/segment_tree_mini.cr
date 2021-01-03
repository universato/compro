class SegmentTree
  @n : (Int64|Int32)
  @n_1 : (Int64|Int32)
  @nodes : Array(Int64)
  @identity_element : Int64

  def initialize(n, form)
    @identity_element =  0_i64
    @func = Proc(Int64, Int64, Int64).new{|x, y| x + y }
    case form
    when "gcd"
      @identity_element = 0_i64
      @func = Proc(Int64, Int64, Int64).new{|x, y| x.gcd y }
    when "min"
      @identity_element =  (1_i64 << 60) - 1
      @func = Proc(Int64, Int64, Int64).new{|x, y| x < y ? x : y }
    when "or"
    #if form == "or"
      @identity_element =  0_i64
      @func = Proc(Int64, Int64, Int64).new{|x, y| x | y }
    end

    @n = 1
    while @n < n
      @n *= 2
    end
    @n_1 = @n - 1
    @nodes = Array(Int64).new(@n*2-1, @identity_element)
  end

  def all_update
    @n_1.downto(1){ |i| @nodes[i-1] = @func.call(@nodes[2*i-1], @nodes[2*i]) }
  end

  def update(i, val)
    i += @n - 1
    @nodes[i] = val
    while i > 0
      i = ( i - 1 ) >> 1
      @nodes[i] = @func.call(@nodes[2*i+1], @nodes[2*i+2])
    end
  end

  def [](i)
    @nodes[@n_1 + i]
  end

  def []=(i, val)
    @nodes[@n_1 + i] = val
  end

  def get(l, r)
    l += @n - 1
    r += @n - 1
    lres, rres = @identity_element, @identity_element
    while l < r
      if 0 == ( l & 1 )
        lres = @func.call(@nodes[l], lres)
        l += 1
      end
      if 0 == ( r & 1 )
        r -= 1
        rres = @func.call(@nodes[r], rres)
      end
      l >>= 1
      r >>= 1
    end
    return @func.call(lres, rres)
  end
end

class Array
  def to_st(form)
    st = SegmentTree.new(size, form)
    each_with_index{ |t, i| st[i] = t }
    st.all_update
    st
  end
end

#  ABC125 C - GCD on Blackboard
n = gets.to_s.to_i64
a = gets.to_s.split.map{|t| t.to_i64 }

st = a.to_st("gcd")

ans = [st.get(1, n), st.get(0, n-1)].max
1.upto(n-2) do |i|
  v = st.get(0, i).gcd st.get(i+1, n)
  ans = v if ans < v
end

puts ans

# yukicoder
#n, q = gets.to_s.split.map{|t| t.to_i64 }
#a    = gets.to_s.split.map{|t| t.to_i64 }
#
#idx = Array.new(n+1){ 0_i64 }
#a.each_with_index{ |t, i| idx[t] = i.to_i64 }
#
#st = a.to_st("min")
#
#q.times do
#  x, l, r = gets.to_s.split.map{|t| t.to_i64 }
#  l -= 1
#  r -= 1
#
#  if x == 1
#    nl = st[l]
#    nr = st[r]
#    idx[nl] = r
#    idx[nr] = l
#    st.update(l, nr)
#    st.update(r, nl)
#  else
#    puts (idx[st.get(l, r+1)] + 1)
#  end
#end

#n = gets.to_s.to_i
#s = gets.to_s.chomp
#q = gets.to_s.to_i
#
## p "a".ord #=> 97
#st = s.chars.map{|c| 1_i64 << (c-'a') }.to_st("or")
#
#q.times do
#
#  t, x, y = gets.to_s.split
#
# if t == "1"
#    i, c = x.to_i-1, y[0].ord
#    st.update(i, 1_i64 << (c-97))
#  else
#    l, r = x.to_i-1, y.to_i-1
#    puts st.get(l, r+1).popcount
#  end
#end

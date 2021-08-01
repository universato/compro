# https://atcoder.jp/contests/practice2/submissions/16901000

struct Int
  def bit_length
    n = self
    res = 0i64
    while n > 0
      res += 1
      n //= 2
    end
    res
  end
end

class LazySegtree
  @n : Int64
  @e : Tuple(Int64, Int64)
  @id : Tuple(Int64, Int64)
  @op : Proc(Tuple(Int64, Int64), Tuple(Int64, Int64), Tuple(Int64, Int64))
  @mapping : Proc(Tuple(Int64, Int64), Tuple(Int64, Int64), Tuple(Int64, Int64))
  @composition : Proc(Tuple(Int64, Int64), Tuple(Int64, Int64), Tuple(Int64, Int64))
  @log : Int64
  @size : Int64
  @d : Array(Tuple(Int64, Int64))
  @lz : Array(Tuple(Int64, Int64))

  def initialize(v, e, id, op, mapping, composition)
    @n  = v.size.to_i64
    @e  = e
    @id = id
    @op = op
    @mapping = mapping
    @composition = composition

    @log  = (@n - 1).bit_length.to_i64
    @size = 1i64 << @log
    @d    = Array.new(2 * @size, e)
    @lz   = Array.new(@size, id)

    @n.times { |i| @d[@size + i] = v[i] }
    (@size - 1).downto(1) { |i| update(i) }
  end

  def set_mapping(&mapping)
    @mapping = mapping
  end

  def set_composition(&composition)
    @composition = composition
  end

  def set(pos, x)
    pos += @size
    @log.downto(1) { |i| push(pos >> i) }
    @d[pos] = x
    1.upto(@log) { |i| update(pos >> i) }
  end

  def get(pos)
    pos += @size
    @log.downto(1) { |i| push(pos >> i) }
    @d[pos]
  end

  def prod(l, r)
    return @e if l == r

    l += @size
    r += @size

    @log.downto(1) do |i|
      push(l >> i) if (l >> i) << i != l
      push(r >> i) if (r >> i) << i != r
    end

    sml = @e
    smr = @e
    while l < r
      if l.odd?
        sml = @op.call(sml, @d[l])
        l += 1
      end
      if r.odd?
        r -= 1
        smr = @op.call(@d[r], smr)
      end
      l >>= 1
      r >>= 1
    end

    @op.call(sml, smr)
  end

  def all_prod
    @d[1]
  end

  def apply(pos, f)
    pos += @size
    @log.downto(1) { |i| push(pos >> i) }
    @d[pos] = @mapping.call(f, @d[pos])
    1.upto(@log) { |i| update(pos >> i) }
  end

  def range_apply(l, r, f)
    return if l == r

    l += @size
    r += @size

    @log.downto(1) do |i|
      push(l >> i) if (l >> i) << i != l
      push((r - 1) >> i) if (r >> i) << i != r
    end

    l2 = l
    r2 = r
    while l < r
      (all_apply(l, f); l += 1) if l.odd?
      (r -= 1; all_apply(r, f)) if r.odd?
      l >>= 1
      r >>= 1
    end
    l = l2
    r = r2

    1.upto(@log) do |i|
      update(l >> i) if (l >> i) << i != l
      update((r - 1) >> i) if (r >> i) << i != r
    end
  end

  def max_right(l, &g)
    return @n if l == @n

    l += @size
    @log.downto(1) { |i| push(l >> i) }
    sm = @e

    loop do
      while l.even?
        l >>= 1
      end
      unless g.call(@op.call(sm, @d[l]))
        while l < @size
          push(l)
          l <<= 1
          if g.call(@op.call(sm, @d[l]))
            sm = @op.call(sm, @d[l])
            l += 1
          end
        end
        return l - @size
      end
      sm = @op.call(sm, @d[l])
      l += 1
      break if l & -l == l
    end
    @n
  end

  def update(k)
    @d[k] = @op.call(@d[2 * k], @d[2 * k + 1])
  end

  def all_apply(k, f)
    @d[k] = @mapping.call(f, @d[k])
    @lz[k] = @composition.call(f, @lz[k]) if k < @size
  end

  def push(k)
    all_apply(2 * k, @lz[k])
    all_apply(2 * k + 1, @lz[k])
    @lz[k] = @id
  end
end

def alpc
  M = 998_244_353
  n, q = gets.to_s.split.map{ |e| e.to_i64 }
  a = gets.to_s.split.map { |e| {e.to_i64, 1_i64} }

  op = Proc(Tuple(Int64, Int64), Tuple(Int64, Int64), Tuple(Int64, Int64)).new{ |ch1, ch2| {(ch1[0] + ch2[0]) % M, ch1[1] + ch2[1]} }
  mapping = Proc(Tuple(Int64, Int64), Tuple(Int64, Int64), Tuple(Int64, Int64)).new{ |f, s| {((f[0] * s[0]) % M + (f[1] * s[1]) % M) % M, s[1]} }
  composition =  Proc(Tuple(Int64, Int64), Tuple(Int64, Int64), Tuple(Int64, Int64)).new{ |fl, fr| {(fl[0] * fr[0]) % M, ((fr[1] * fl[0]) % M + fl[1]) % M} }

  lst = LazySegtree.new(a, {0i64, 0i64}, {1i64, 0i64}, op, mapping, composition)

  q.times do
    query = gets.to_s.split.map{ |e| e.to_i64 }
    if query[0] == 0
      _, l, r, a, b = query
      lst.range_apply(l, r, {a, b})
    else
      _, l, r = query
      puts lst.prod(l, r)[0]
    end
  end
end

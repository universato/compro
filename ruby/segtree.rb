# Segment Tree
class Segtree
  attr_reader :d, :op, :n, :leaf_size, :log

  # new(e){ |x, y|  }     <- deprecated
  # new(v){ |x, y|  }
  # new(n, e){ |x, y|  }  ex) Segtree.new(3, 1){ |x, y| x * y }
  # new(n, op, e)         ex) Segtree.new(3, proc{ |x, y| x ^ y }, 0)
  # new(a, e){ |x, y|  }  ex) Segtree.new([1, 2, 3], 0){ |x, y| x + y }
  # new(a, op, e)         ex) Segtree.new([1, 2, 3], proc{ |x, y| x ^ y }, 0)
  def initialize(a0, a1 = nil, a2 = nil, &block)
    if a1.nil?
      v, @op = (a0.is_a?(Array) ? a0 : [@e] * a0), proc(&block)
      @e = nil
    elsif a2.nil?
      @e, @op = a1, proc(&block)
      v = (a0.is_a?(Array) ? a0 : [@e] * a0)
    else
      @op, @e = a1, a2
      v = (a0.is_a?(Array) ? a0 : [@e] * a0)
    end

    @n = v.size
    @log = (@n - 1).bit_length
    @leaf_size = 1 << @log
    @d = Array.new(@leaf_size * 2, @e)
    v.each_with_index { |v_i, i| @d[@leaf_size + i] = v_i }
    (@leaf_size - 1).downto(1) { |i| update(i) }
  end

  def set(q, x)
    q += @leaf_size
    @d[q] = x
    1.upto(@log) { |i| update(q >> i) }
  end
  alias []= set

  def get(pos)
    @d[@leaf_size + pos]
  end
  alias [] get

  def prod(l, r)
    return @e if l == r

    sml = @e
    smr = @e
    l += @leaf_size
    r += @leaf_size

    while l < r
      if l[0] == 1
        if sml.nil?
          sml = @d[l]
        else
          dl = @d[l]
          sml = @op.call(sml, @d[l]) unless dl.nil?
        end
        l += 1
      end
      if r[0] == 1
        r -= 1
        if smr.nil?
          smr = @d[r]
        else
          dr = @d[r]
          smr = @op.call(@d[r], smr) unless dr.nil?
        end
      end
      l /= 2
      r /= 2
    end

    __op(sml, smr)
  end

  private def __op(l, r)
    if l.nil?
      r
    elsif r.nil?
      l
    else
      @op.call(l, r)
    end
  end

  def all_prod
    @d[1]
  end

  def max_right(l, &block)
    return @n if l == @n

    f = proc(&block)

    l += @leaf_size
    sm = @e
    loop do
      l /= 2 while l.even?
      unless f.call(__op(sm, @d[l]))
        while l < @leaf_size
          l *= 2
          if f.call(__op(sm, @d[l]))
            sm = __op(sm, @d[l])
            l += 1
          end
        end

        return l - @leaf_size
      end

      sm = __op(sm, @d[l])
      l += 1
      break if (l & -l) == l
    end

    @n
  end

  def min_left(r, &block)
    return 0 if r == 0

    f = proc(&block)

    r += @leaf_size
    sm = @e
    loop do
      r -= 1
      r /= 2 while r > 1 && r.odd?
      unless f.call(__op(@d[r], sm))
        while r < @leaf_size
          r = r * 2 + 1
          if f.call(__op(@d[r], sm))
            sm = __op(@d[r], sm)
            r -= 1
          end
        end

        return r + 1 - @leaf_size
      end

      sm = __op(@d[r], sm)
      break if (r & -r) == r
    end

    0
  end

  def update(k)
    x = @d[2 * k]
    if x.nil?
      @d[k] = @d[2 * k + 1]
    else
      y = @d[2 * k + 1]
      @d[k] = y.nil? ? x : @op.call(x, y)
    end
  end

  # WIP
  # def inspect
  #   t = 0
  #   res = "SegmentTree @e = #{@e}, @n = #{@n}, @leaf_size = #{@leaf_size} \n  "
  #   a = @d[1, @d.size - 1]
  #   a.each_with_index do |e, i|
  #     res << e.to_s.rjust(2) << ' '
  #     if t == i && i < @leaf_size
  #       res << "\n  "
  #       t = t * 2 + 2
  #     end
  #   end
  #   res
  # end

  # [TODO]
  # def inspect2
  #   t = 0
  #   head = "SegmentTree @e = #{@e}, @n = #{@n}, @leaf_size = #{@leaf_size} \n"
  #   base = Math.log2(@leaf_size * 2).to_i

  #   ls = Array.new(@leaf_size)
  #   bodies = []
  #   (baes..base).each do |rank|
  #     s = 2**(rank - 1)
  #     t = 2**rank - 1
  #     tmp = []
  #     tmp_len = 0
  #     (s..t).each do |i|
  #       k = @d[i].inspect
  #       tmp << k
  #       tmp << ' '
  #       if i.even?
  #         tmp_len += k.to_s
  #       else
  #         tmp_len + tmp[]
  #       end
  #     end
  #   end
  #   bodies << tmp

  #   (base - 1).downto(1) do |rank|
  #     s = 2**(rank - 1)
  #     t = 2**rank - 1
  #     tmp = ""
  #     ls = (s..t).map do |i|
  #       k = @d[i].inspect
  #       tmp << k
  #       k.size
  #     end
  #   end
  #   res
  # end
end

SegTree     = Segtree
SegmentTree = Segtree

a = (0..5).to_a
# p Segtree.new(a, 0){ |x, y| x + y }

#1          1
#2      2          3
#3   4    5     6     7
#4  8 9 10 11 12 13 14 15     2**(4 - 1)

#  17  21
# 8 9 10 11

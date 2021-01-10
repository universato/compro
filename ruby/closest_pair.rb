class Point
  def initialize(x, y)
    @x, @y = x, y
  end

  include Comparable
  def ==(other)
    y == other.y
  end
  def <=>(other)
    y <=> other.y
  end
  attr_accessor :x, :y

  def inspect
    "(#{@x} #{@y})"
  end
end

# def partial_sort(i, n)
#   t = @a.pop(@a.size - n)
#   s = @a.shift(i)
#   # p a
#   @a.sort!{ |e| yield(e) }
#   @a.unshift(*s)
#   @a.concat(t)
#   @a
# end

# def inplace_merge(a, first, middle, last)
#   i = first
#   j = middle
#   while i < j && j < last
#     if a[i] < a[j]
#       i += 1
#     else
#       a.insert(i, a.delete_at(j))
#       i += 1
#       j += 1
#     end
#   end
# end

# def brute_force(idx, n)
#   r = @a[idx]
#   s = @a[idx + 1]
#   t = @a[idx + 2] if n == 3

#   d = Math.hypot(r.x - s.x, r.y - s.y)
#   return d if n == 2

#   [d, Math.hypot(t.x - s.x, t.y - s.y), Math.hypot(t.x - r.x, t.y - r.y)].min
# end

# Array
class Array
  def partial_sort(i, n)
    t = pop(size - n)
    s = shift(i)
    # p [s, t, self]
    # p self
    sort_by!{ |e| yield(e) }
    unshift(*s)
    concat(t)
    # p self
    self
  end
  def brute_force(idx, n)
    r = self[idx]
    s = self[idx + 1]
    t = self[idx + 2] if n == 3

    d = Math.hypot(r.x - s.x, r.y - s.y)
    return d if n == 2

    [d, Math.hypot(t.x - s.x, t.y - s.y), Math.hypot(t.x - r.x, t.y - r.y)].min
  end

  def inplace_merge(first, middle, last)
    i = first
    j = middle
    while i < j && j < last
      if self[i] < self[j]
        i += 1
      else
        insert(i, delete_at(j))
        i += 1
        j += 1
      end
    end
  end

  def closest_pair(idx = 0, n = size)
    return Float::INFINITY if n <= 1

    # return brute_force(idx, n) if n <= 3

    m = n / 2
    x = self[idx + m].x

    d = [closest_pair(idx, m), closest_pair(idx + m, n - m)].min
    # partial_sort(idx, n){ |point| point.y }
    inplace_merge(idx, idx + m, idx + n)
    # p [idx, self[idx], m, n, d, self[idx, n]]

    b = []
    n.times do |i|
      # p [@a[i], x, d]
      i += idx
      point_i = self[i]
      next if (point_i.x - x).abs >= d

      1.upto(b.size) do |j|
        dx = point_i.x - b[-j].x
        dy = point_i.y - b[-j].y
        # p [b.size, j, dx, dy]
        break if dy >= d

        # p [d, Math.sqrt(dx * dx + dy * dy)]
        d = [d, Math.sqrt(dx * dx + dy * dy)].min
      end
      b.push(point_i)
      # p b
    end
    # p [idx, self[idx], m, n, d, self[idx, n]]
    d
  end
end

# def closest_pair旧(idx, n)
#   return Float::INFINITY if n <= 1
#   return brute_force(idx, n) if n <= 3

#   m = n / 2
#   x = @a[idx + m].x

#   d = [closest_pair(0, m), closest_pair(m, n - m)].min
#   partial_sort(idx, n){ |point| point.y }
#   # inplace_sort(@idx, m, n)

#   b = []
#   n.times do |i|
#     # p [@a[i], x, d]
#     next if (@a[i].x - x).abs >= d

#     (m = b.size).times do |j|
#       dx = @a[idx + i].x - b[-j].x
#       dy = @a[idx + i].y - b[-j].y
#       break if dy >= d

#       d = [d, Math.sqrt(dx * dx + dy * dy)].min
#     end
#     b.push(@a[i])
#   end
#   d
# end

def arihon
  n = 5
  x = [0, 6, 43, 39, 189]
  y = [2, 67, 71, 107, 140]
  a = x.zip(y).map{ |(x, y)| Point.new(x.to_f, y.to_f) }.sort_by{ |point| point.x }

  p a.closest_pair
  # p closest_pair(0, n) # 36.2215 # 36.22154055254967
end

def cgl5a
  n = gets.to_s.to_i
  a = Array.new(n){ x, y = gets.split.map{ |e| e.to_f }; Point.new(x, y) }.sort_by{ |point| point.x }
  puts "%.10f\n" % a.closest_pair
end

# arihon
cgl5a

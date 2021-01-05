class Point
  def initialize(x, y)
    @x, @y = x, y
  end
  attr_accessor :x, :y
end

def partial_sort(i, n)
  t = @a.pop(@a.size - n)
  s = @a.shift(i)
  # p a
  a.sort!{ |e| yield(e) }
  @a.unshift(*s)
  @a.concat(t)
  @a
end

def inplace_merge

end

def brute_force(idx, n)
  r = @a[idx]
  s = @a[idx + 1]
  t = @a[idx + 2] if n == 3

  d = Math.hypot(r.x - s.x, r.y - s.y)
  return d if n == 2

  [d, Math.hypot(t.x - s.x, t.y - s.y), Math.hypot(t.x - r.x, t.y - r.y)].min
end

def closest_pair(idx, n)
  return Float::INFINITY if n <= 1
  return brute_force(idx, n) if n <= 3

  m = n / 2
  x = @a[idx + m].x

  d = [closest_pair(0, m), closest_pair(m, n - m)].min
  partial_sort(idx, n){ |point| point.y }
  # inplace_sort(@idx, m, n)

  b = []
  n.times do |i|
    # p [@a[i], x, d]
    next if (@a[i].x - x).abs >= d

    (m = b.size).times do |j|
      dx = @a[idx + i].x - b[-j].x
      dy = @a[idx + i].y - b[-j].y
      break if dy >= d

      d = [d, Math.sqrt(dx * dx + dy * dy)].min
    end
    b.push(@a[i])
  end
  d
end

def arihon
  n = 5
  x = [0, 6, 43, 39, 189]
  y = [2, 67, 71, 107, 140]
  @a = x.zip(y).map{ |(x, y)| Point.new(x.to_f, y.to_f) }

  p closest_pair(0, n)
end

def cgl5a
  n = gets.to_s.to_i
  @a = Array.new(n){ x, y = gets.split.map{ |e| e.to_f }; Point.new(x, y) }.sort_by{ |point| point.x }
  puts "%.10f\n" % closest_pair(0, n)
end

cgl5a

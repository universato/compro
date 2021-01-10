
def cgl1a
  xs, ys, xt, yt = gets.to_s.split.map{ |t| t.to_f }

  o = Point.new(xs, ys)
  a = Point.new(xt, yt)
  l = Line.new(o, a)

  q = gets.to_s.to_i
  q.times do
    x, y = gets.to_s.split.map{ |t| t.to_f }
    ans = l.project(Point.new(x, y))
    puts "#{ans.x} #{ans.y}"
  end
end

def cgl1b
  xs, ys, xt, yt = gets.to_s.split.map{ |t| t.to_f }

  o = Point.new(xs, ys)
  a = Point.new(xt, yt)
  l = Line.new(o, a)

  q = gets.to_s.to_i
  q.times do
    x, y = gets.to_s.split.map{ |t| t.to_f }
    ans = l.reflect(Point.new(x, y))
    puts "#{ans.x} #{ans.y}"
  end
end

def cgl1c
  xs, ys, xt, yt = gets.to_s.split.map{ |t| t.to_f }

  o = Point.new(xs, ys)
  a = Point.new(xt, yt)
  l = Line.new(o, a)

  q = gets.to_s.to_i
  q.times do
    x, y = gets.to_s.split.map{ |t| t.to_f }
    t = o.ccw(a, Point.new(x, y))
    puts POINTS_POSITION[t]
  end
end

def cgl2a
  q = gets.to_s.to_i
  q.times do
    x0, y0, x1, y1, x2, y2, x3, y3 = gets.to_s.split.map{ |t| t.to_f }
    p0 = Point.new(x0, y0)
    p1 = Point.new(x1, y1)
    p2 = Point.new(x2, y2)
    p3 = Point.new(x3, y3)
    s1 = Line.new(p0, p1)
    s2 = Line.new(p2, p3)

    if s1.parallel?(s2)
      puts 2
    elsif s1.orthogonal?(s2)
      puts 1
    else
      puts 0
    end
  end
end

def cgl2b
  q = gets.to_s.to_i
  q.times do
    x0, y0, x1, y1, x2, y2, x3, y3 = gets.to_s.split.map{ |t| t.to_f }
    p0 = Point.new(x0, y0)
    p1 = Point.new(x1, y1)
    p2 = Point.new(x2, y2)
    p3 = Point.new(x3, y3)
    s1 = Line.new(p0, p1)
    s2 = Line.new(p2, p3)

    puts s1.intersect?(s2) ? 1 : 0
  end
end

def cgl2c
  q = gets.to_s.to_i
  q.times do
    x0, y0, x1, y1, x2, y2, x3, y3 = gets.to_s.split.map{ |t| t.to_f }
    p0 = Point.new(x0, y0)
    p1 = Point.new(x1, y1)
    p2 = Point.new(x2, y2)
    p3 = Point.new(x3, y3)
    s1 = Line.new(p0, p1)
    s2 = Line.new(p2, p3)

    puts s1.cross_point(s2)
  end
end

def cgl2d
  q = gets.to_s.to_i
  q.times do
    x0, y0, x1, y1, x2, y2, x3, y3 = gets.to_s.split.map{ |t| t.to_f }
    p0 = Point.new(x0, y0)
    p1 = Point.new(x1, y1)
    p2 = Point.new(x2, y2)
    p3 = Point.new(x3, y3)
    s1 = Line.new(p0, p1)
    s2 = Line.new(p2, p3)

    ans = s1.distance(s2)
    puts ans
  end
end

def cgl3a
  g = Polygon.new
  q = gets.to_s.to_i
  q.times do
    x, y = gets.to_s.split.map{ |t| t.to_f }
    v = Point.new(x, y)
    g.add_point(v)
  end

  puts g.area
end

def cgl3b
  g = Polygon.new
  q = gets.to_s.to_i
  q.times do
    x, y = gets.to_s.split.map{ |t| t.to_f }
    v = Point.new(x, y)
    g.add_point(v)
  end

  puts g.convex? ? 1 : 0
end

def cgl3c
  g = Polygon.new
  n = gets.to_s.to_i
  n.times do
    x, y = gets.to_s.split.map{ |t| t.to_f }
    v = Point.new(x, y)
    g.add_point(v)
  end

  q = gets.to_s.to_i
  q.times do
    x, y = gets.to_s.split.map{ |t| t.to_f }
    v = Point.new(x, y)
    puts g.include?(v)
  end
end

def cgl4a
  g = Polygon.new
  n = gets.to_s.to_i
  n.times do
    x, y = gets.to_s.split.map{ |t| t.to_i }
    g.add_point(xy(x, y))
  end

  g.andrew_scan.out
end

def cgl4b
  g = Polygon.new
  n = gets.to_s.to_i
  n.times do
    x, y = gets.to_s.split.map{ |t| t.to_f }
    g.add_point(xy(x, y))
  end

  puts g.diameter
end

def cgl4c
  g = Polygon.new
  n = gets.to_s.to_i
  n.times do
    x, y = gets.to_s.split.map{ |t| t.to_f }
    g.add_point(xy(x, y))
  end

  q = gets.to_s.to_i
  q.times do
    xs, ys, xt, yt = gets.to_s.split.map{ |t| t.to_f }
    l = line(xs, ys, xt, yt)
    puts g.cut(l).area
  end
end

def cgl5a
  # [TODO]
  n = gets.to_s.to_i
  x, y = Polygon.new(n){ Point.gets }.closest_pair
  puts x.dist(y)
end

def cgl5a
  n = gets.to_s.to_i
  @a = Array.new(n){ x, y = gets.split.map{ |e| e.to_f }; Point.new(x, y) }.sort_by{ |point| point.x }
  puts "%.10f\n" % closest_pair(0, n)
end

def cgl6a
  # [TODO]
end

def cgl7a
  xc0, yc0, r0 = gets.to_s.split.map{ |t| t.to_f }
  xc1, yc1, r1 = gets.to_s.split.map{ |t| t.to_f }

  c0 = Circle.new(xy(xc0, yc0), r0)
  c1 = Circle.new(xy(xc1, yc1), r1)

  puts c0.relation(c1)
end

def cgl7b
  t = Triangle.new{ Point.geti }
  puts t.inscribed_circle
end

def cgl7c
  t = Triangle.new{ Point.geti }
  puts t.circumscribed_circle
end

def cgl7d
  x, y, r = gets.to_s.split.map{ |t| t.to_f }
  c = Circle.new(xy(x, y), r)
  q = gets.to_s.to_i
  q.times do
    xs, ys, xt, yt = gets.to_s.split.map{ |t| t.to_f }
    ln = line(xs, ys, xt, yt)
    ans = c.cross_points(ln)
    puts ans.join(" ")
  end
end

def cgl7e
  x, y, r = gets.to_s.split.map{ |t| t.to_f }
  x1, y1, r1 = gets.to_s.split.map{ |t| t.to_f }

  c = Circle.new(xy(x, y), r)
  c1 = Circle.new(xy(x1, y1), r1)
  puts c1.cross_points(c).join(" ")
end

def cgl7f
  v = Point.getf
  c = Circle.getf
  ans = c.contact_points(v).sort
  puts ans
end

def cgl7g
  c1 = Circle.getf
  c2 = Circle.getf
  lines = c1.common_tangent_to_circle(c2)
  ans = lines.map{ |line| line.s }.sort
  # p ans.map{ |point| point.inspect }
  puts ans
end

def cgl7h
  # [TODO]
end

def cgl7i
  c1 = Circle.getf
  c2 = Circle.getf
  puts c1.area_of_intersection_with_circle(c2)
end

def abc016
  karate_chop = Line.geti
  n = gets.to_s.to_i
  board = Array.new(n){ Point.geti }
  board << board[0]

  cross_count = board.each_cons(2).count{ |s, t| karate_chop.intersect?(line(s, t)) }

  puts cross_count / 2 + 1
end

def abc022
  n = gets.to_s.to_i
  a = Polygon.new(n){ Point.geti }
  b = Polygon.new(n){ Point.geti }

  ga = a.center_of_gravity
  gb = b.center_of_gravity

  la = a.max_by{ |q| ga.dist(q) }.abs
  lb = b.max_by{ |q| gb.dist(q) }.abs

  puts lb / la
end

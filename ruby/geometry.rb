require 'forwardable'

EPS = 1e-10
COUNTER_CLOCKWISE = 1
CLOCKWISE    = -1
ONLINE_BACK  =  2
ONLINE_FRONT = -2
ON_SEGMENT   =  0
POINTS_POSITION = { 1 => :COUNTER_CLOCKWISE, -1 => :CLOCKWISE, 2 => :ONLINE_BACK, -2 => :ONLINE_FRONT, 0 => :ON_SEGMENT }.freeze

# Numeric
class Numeric
  def equals(d)
    (self - d).abs < EPS
  end
end

# Point
class Point
  include Math
  include Comparable

  def initialize(x = 0.0, y = 0.0)
    @x = x
    @y = y
  end
  attr_accessor :x, :y

  class << self
    def origin
      Point.new(0.0, 0.0)
    end
  end

  def +(other)
    Point.new(@x + other.x, @y + other.y)
  end

  def -(other)
    Point.new(@x - other.x, @y - other.y)
  end

  def -@
    Point.new(-@x, -@y)
  end

  def *(a)
    Point.new(@x * a, @y * a)
  end

  def /(a)
    Point.new(@x / a, @y / a)
  end

  def norm
    @x * @x + @y * @y
  end

  def abs
    sqrt(@x * @x + @y * @y)
  end

  def dist(other = nil)
    other.nil? ? hypot(@x, @y) : hypot(@x - other.x, @y - other.y)
  end

  def distance_to_point(other)
    (self - other).abs
  end
  alias getDistance distance_to_point

  def distance_to_line(l)
    b = l.t - l.s
    b.cross(self - l.s).abs / b.abs
  end

  def distance_to_segment(s)
    return (self - s.s).abs if (s.t - s.s).dot(v - s.s) < 0.0
    return (self - s.t).abs if (s.s - s.t).dot(v - s.t) < 0.0

    distance_to_line(s)
  end

  def <=>(other)
    @x != other.x ? @x <=> other.x : @y <=> other.y
  end

  def ==(other)
    (@x - other.x).abs < EPS && (@y - other.y).abs < EPS
  end

  def dot(other)
    @x * other.x + @y * other.y
  end

  def cross(other)
    @x * other.y - @y * other.x
  end

  def orthogonal?(other)
    dot(other).abs < EPS
  end

  def parallel?(other)
    cross(other).abs < EPS
  end

  def project(l)
    base = l.t - l.s
    r = (self - l.s).dot(base) / base.norm
    l.s + base * r
  end

  def reflect(l)
    self + (project(l) - self) * 2
  end

  def ccw(v1, v2)
    a = v1 - self
    b = v2 - self
    return COUNTER_CLOCKWISE if a.cross(b) >  EPS
    return CLOCKWISE         if a.cross(b) < -EPS
    return ONLINE_BACK       if a.dot(b)   < -EPS
    return ONLINE_FRONT      if a.norm     < b.norm

    return ON_SEGMENT
  end

  # 三点が作る三角形の面積
  def area(v1, v2 = nil)
    v2 = Point.new(0.0, 0.0) if v2.nil?
    a = self - v2
    b = v1   - v2
    (a.x * b.y - a.y * b.x) / 2.0
  end

  def arg
    Math.atan2(@y, @x)
  end

  def rot90
    Point.new(-@y, @x)
  end

  def to_line
    Line.new(Point.origin, self)
  end
  alias to_segment to_line

  def origin?
    @x.abs < EPS && @y.abs < EPS
  end

  def to_a
    [@x, @y]
  end

  def [](i)
    case i
    when 0
      @x
    when 1, -1
      @y
    else
      raise ArgumentError
    end
  end

  def to_s
    "#{@x.round(12)} #{@y.round(12)}"
  end

  # def to_s; "#{x} #{y}" end
  def inspect
    "Point(#{@x}, #{@y})"
  end

  def out
    puts "#{@x} #{@y}"
  end
end

# Line
class Line
  def initialize(s, t)
    @s = s
    @t = t
  end
  attr_accessor :s, :t

  def orthogonal?(l)
    (@s - @t).dot(l.s - l.t).abs < EPS
  end

  def parallel?(l)
    (@s - @t).cross(l.s - l.t).abs < EPS
  end

  def project(v)
    base = @t - @s
    r = 1.0 * (v - @s).dot(base) / base.norm
    @s + base * r
  end

  def reflect(v)
    v + (project(v) - v) * 2.0
  end

  def getDistanceLP(v)
    ((@t - @s).cross(v - @s) / (@t - @s).abs).abs
  end

  def getDistanceSP(v)
    return (v - @s).abs if (@t - @s).dot(v - @s) < 0.0
    return (v - @t).abs if (@s - @t).dot(v - @t) < 0.0

    getDistanceLP(v)
  end

  def intersect?(l)
    @s.ccw(@t, l.s) * @s.ccw(@t, l.t) <= 0 && l.s.ccw(l.t, @s) * l.s.ccw(l.t, @t) <= 0
  end

  def distance(l)
    return 0.0 if intersect?(l)

    res = getDistanceSP(l.s)
    m1 = getDistanceSP(l.t)
    m2 = l.getDistanceSP(@s)
    m3 = l.getDistanceSP(@t)
    res = m1 if res > m1
    res = m2 if res > m2
    res = m3 if res > m3
    res
  end
  alias getDistance distance

  def cross_point(l)
    base = @t - @s
    d1   = base.cross(l.t - l.s).abs
    d2   = base.cross(@t  - l.s).abs #
    return l.s if d1.abs < EPS && d2.abs < EPS # same line!!
    return warn "!!!PRECONDITION NOT SATISFIED!!!" if d1.abs < EPS

    l.s + (l.t - l.s) * 1.0 * d2 / d1
  end
  alias getCrossPoint cross_point

  def ==(other)
    @s == other.s && @t == other.t
  end

  def to_point
    Point.new(@t.x - @s.x, @t.y - @s.y)
  end

  def to_s
    "#{@s} #{@t}"
  end

  def inspect
    "[(#{@s.x}, #{@s.y}) -> (#{@t.x}, #{@t.y})]"
  end
end
Segment = Line

# Polygon
class Polygon
  def initialize(points = [])
    @points = points
  end
  attr_accessor :points

  extend Forwardable
  def_delegators(:@points, :push, :pop, :size)
  alias add_point push

  def area
    o = @points[-1]
    (0...@points.size - 1).sum{ |i| o.area(@points[i - 1], @points[i]) }.abs
  end

  def convex?
    n = @points.size
    if n == 3
      x = @points[0]
      y = @points[1]
      z = @points[2]
      return x.ccw(y, z).abs == 1
    end
    n.times do |i|
      x = @points[i]
      y = @points[(i + 1) % n]
      z = @points[(i + 2) % n]
      return false if x.ccw(y, z) == CLOCKWISE || x.ccw(y, z) == ONLINE_BACK
    end
    true
  end

  ON_EDGE = 1
  IN_POLYGON = 2
  OUT_OF_POLYGON = 0
  def include?(v)
    n = @points.size
    f = false
    n.times do |i|
      a = @points[i] - v
      b = @points[(i + 1) % n] - v
      return 1 if a.cross(b).abs < EPS && a.dot(b) < EPS

      a, b = b, a if a.y > b.y
      f = !f if a.y < EPS && EPS < b.y && a.cross(b) > EPS
    end
    f ? 2 : 0
  end
  alias includes? include?
  alias contain? include?
  alias contain include?

  def sort!
    points.sort!{ |a, b| (a.y <=> b.y).nonzero? || a.x <=> b.x }
  end

  def andrew_scan
    u = Polygon.new
    l = Polygon.new
    return self if size < 3

    sort!

    u.push(points[0], points[1], points[-1], points[-2])

    (2...size).each do |i|
      (u.size).downto(2) do |n|
        break if u.points[n - 2].ccw(u.points[n - 1], points[i]) != COUNTER_CLOCKWISE

        u.pop
      end
      u.push(points[i])
    end

    (size - 3).downto(0) do |i|
      (l.size).downto(2) do |n|
        break if l.points[n - 2].ccw(l.points[n - 1], points[i]) != COUNTER_CLOCKWISE

        l.pop
      end
      l.push(points[i])
    end

    l.points.reverse!
    (u.size - 2).downto(1){ |i| l.push(u.points[i]) }
    l
  end
  alias andrewScan andrew_scan

  def diameter
    n = size
    is = js = 0
    n.times do |i|
      is = i if points[i].y > points[is].y
      js = i if points[i].y < points[js].y
    end

    dmax = (points[is] - points[js]).dist

    i = maxi = is
    j = maxj = js
    loop do
      if (points[(i + 1) % n] - points[i]).cross(points[(j + 1) % n] - points[j]) >= 0
        j = (j + 1) % n
      else
        i = (i + 1) % n
      end
      d = (points[i] - points[j]).dist
      if d > dmax
        dmax = d
        maxi = i
        maxj = j
      end
      break if i == is && j == js
    end
    dmax
  end

  def cut(ln)
    n = size
    q = Polygon.new
    n.times do |i|
      cur = points[i]
      nex = points[(i + 1) % n]
      q.push(cur) if ln.s.ccw(ln.t, cur) != CLOCKWISE
      q.push(ln.cross_point(line(cur, nex))) if ln.s.ccw(ln.t, cur) * ln.s.ccw(ln.t, nex) < 0
    end
    q
  end

  def out
    puts size
    puts points
  end

  def pout
    puts size
    puts points.map(&:inspect)
  end
end

# Circle
class Circle
  def initialize(c = Point.new(0.0, 0.0), r = 0.0)
    @c = c
    @r = r
  end
  attr_accessor :c, :r
  alias center c
  alias radius r

  class << self
    def unit_ciercle
      Circle.new(Point.new(0.0, 0.0), 1.0)
    end
  end

  include Math

  def relation(other)
    d = (@c - other.c).dist

    r_sum = @r + other.r
    return 4 if d > r_sum
    return 3 if d == r_sum

    r0, r1 = @r, other.r
    r0, r1 = other.r, r if other.r < @r
    r_diff = r1 - r0
    return 2 if d > r_diff # && d < r_sum

    warn "完全一致" if r_diff == 0 && d == 0
    return 1 if d == r_diff

    return 0 # if d < r_diff
  end
  alias number_of_common_tangents relation

  def intersection_to_line(line)
    warn "円と線は交わらない(接していない含む)" if @r < @c.distance_to_line(line)
    pr   = l.project(@c)
    e    = (l.t - l.s) / (l.t - l.s).abs # unit vector
    base = sqrt(@r * @r - (pr - c).norm)
    t    = e * base
    [pr - t, pr + t] # .sort{ |a, b| (a.x <=> b.x).nonzero? || a.y <=> b.y }
  end
  alias cross_points_to_line intersection_to_line

  def intersection_to_circle(other)
    # 途中、螺旋本p.397
    d = @c.dist(other.c)
    warn "両円は交わらない(接していない含む)" if d > @r + other.r
    a = Math.acos(Rational(@r * @r + d * d - other.r**2, 2.0 * @r * d))
    t = (other.c - @c).arg
    [c + polar(r, t + a), c + polar(r, t - a)] # .sort{ |a, b| (a.x <=> b.x).nonzero? || a.y <=> b.y }
  end
  alias cross_points_to_circle intersection_to_circle

  def cross_points(other)
    if other.instance_of?(Line)
      l = other
      warn "円と線は交わらない中(接していない含む)、交点を求めようとしました" if l.getDistanceLP(@c) > @r
      pr = l.project(@c)
      e    = (l.t - l.s) / (l.t - l.s).abs # unit vector
      base = sqrt(@r * @r - (pr - c).norm)
      t = e * base
      return [pr - t, pr + t].sort{ |a, b| (a.x <=> b.x).nonzero? || a.y <=> b.y }
    elsif other.instance_of?(Circle)
      # 途中、螺旋本p.397
      d = @c.dist(other.c)
      warn "両円が交わらない中(接していない含む)、交点を求めようとしました" if d > @r + other.r
      a = Math.acos(Rational(@r * @r + d * d - other.r**2, 2.0 * @r * d))
      t = (other.c - @c).arg
      return [c + polar(r, t + a), c + polar(r, t - a)].sort{ |a, b| (a.x <=> b.x).nonzero? || a.y <=> b.y }
    end
  end
  alias getCrossPoints cross_points

  def common_tangent(other)
    if other.instance_of?(Point)
      # refer to drken-san
      # http://judge.u-aizu.ac.jp/onlinejudge/review.jsp?rid=3140448#1
      d = (other - @c).norm
      l = d - @r * @r
      return Point.new(0, 0) if l < -EPS

      l = 0.0 if l <= 0.0
      cq = (other - @c) * (@r * @r / d)
      qs = ((other - @c) * (@r * sqrt(l) / d)).rot90
      return [@c + cq + qs, c + cq - qs].sort{ |a, b| (a.x <=> b.x).nonzero? || a.y <=> b.y }
    elsif other.instance_of?(Circle)

      # TODO: 工事中

    end
    p "???"
  end
end

def point(x, y)
  Point.new(x, y)
end
alias xy point
alias Point point

def line(a, b = nil, c = nil, d = nil)
  if b
    c ? Line.new(xy(a, b), xy(c, d)) : Line.new(a, b)
  else
    Line.new(*a)
  end
end

def circle(x, y, r)
  Circle.new(Point.new(x, y), r)
end
alias Circle circle

def triangle(a, b = nil, c = nil, d = nil, e = nil, f = nil)
  res = Polygon.new
  if f
    res.push(point(a, b), point(c, d), point(e, f))
  elsif c
    res.push(a, b, c)
  end
  res
end

def rect(x, y, w, h)
  res = Polygon.new
  res.push(x, y)
  res.push(x + h, y)
  res.push(x + w, y + h)
  res.push(x, y + h)
end

def polar(a, r)
  Point.new((Math.cos(r) * a).round(13), (Math.sin(r) * a).round(13))
end

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

    ans = s1.getDistance(s2)
    puts ans
  end
end

def cgl3a
  q = gets.to_s.to_i

  g = Polygon.new
  q.times do
    x, y = gets.to_s.split.map{ |t| t.to_f }
    v = Point.new(x, y)
    g.add_point(v)
  end

  puts g.area
end

def cgl3b
  q = gets.to_s.to_i

  g = Polygon.new
  q.times do
    x, y = gets.to_s.split.map{ |t| t.to_f }
    v = Point.new(x, y)
    g.add_point(v)
  end

  puts g.convex? ? 1 : 0
end

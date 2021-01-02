require 'forwardable'

EPS = 1e-10
COUNTER_CLOCKWISE = 1
CLOCKWISE    = -1
ONLINE_BACK  =  2
ONLINE_FRONT = -2
ON_SEGMENT   =  0
POINTS_POSITION = { COUNTER_CLOCKWISE: 1, CLOCKWISE: -1, ONLINE_BACK: 2, ONLINE_FRONT: -2, ON_SEGMENT: 0 }.invert

# Numeric
class Numeric
  def equals(other)
    (other - self).abs < EPS
  end
end

# Array
class Array
  def to_point
    Point.new(*self)
  end

  def to_points
    each_slice(2).map{ |x, y| Point.new(x, y) }
  end

  def to_circle
    cx, cy, r = self
    Circle.new(Point.new(cx, cy), r)
  end
end

# String
class String
  def to_point
    x, y = split.map{ |t| t.to_f }
    Point.new(x, y)
  end

  def to_circle
    cx, cy, r = split.map{ |t| t.to_f }
    Circle.new(Point.new(cx, cy), r)
  end

  def to_line
    sx, sy, tx, ty = split.map{ |t| t.to_f }
    Line.new(Point(sx, sy), Point.new(tx, ty))
  end
end

# Point
class Point
  include Math
  include Comparable

  def initialize(x = 0, y = 0)
    @x = x
    @y = y
  end
  attr_accessor :x, :y

  class << self
    # def gets
    #   str = Kernel.gets or return nil
    #   x, y = str.split.map{ |t| t.to_f }
    #   Point.new(x, y)
    # end

    def getf
      str = Kernel.gets or return nil
      x, y = str.split.map{ |t| t.to_f }
      Point.new(x, y)
    end

    def geti
      str = Kernel.gets or return nil
      x, y = str.split.map{ |t| t.to_i }
      Point.new(x, y)
    end

    def origin
      Point.new(0.0, 0.0)
    end

    def polar(r, θ)
      Point.new(Math.cos(θ) * r, Math.sin(θ) * r)
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

  def *(k)
    Point.new(@x * k, @y * k)
  end

  def /(k)
    Point.new(@x / k, @y / k)
  end

  def fdiv(k)
    Point.new(@x.fdiv(k), @y.fdiv(k))
  end

  def quo(k)
    Point.new(@x.quo(k), @y.quo(k))
  end

  def abs2
    @x * @x + @y * @y
  end
  alias sum_of_squares abs2
  # alias norm abs2
  alias ss abs2

  def abs
    sqrt(@x * @x + @y * @y)
  end
  # alias length abs

  def dist(other = nil)
    other.nil? ? hypot(@x, @y) : hypot(@x - other.x, @y - other.y)
  end

  def distance_to(other)
    case other
    when Point   then distance_to_point(other)
    when Segment then distance_to_segment(other)
    when Line    then distance_to_line(other)
    when Circle  then distance_to_circle(other)
    else raise ArgumentError end
  end
  # alias getDistance distance_to

  def distance_to_point(other)
    (other - self).abs
  end

  def distance_to_line(l)
    b = l.t - l.s
    b.cross(self - l.s).abs / b.abs
  end

  def distance_to_segment(s)
    (s.t - s.s).dot(v = (self - s.s)) < 0.0 and return v.abs
    (s.s - s.t).dot(v = (self - s.t)) < 0.0 and return v.abs

    distance_to_line(s)
  end

  def distance_to_circle(circle)
    diff = (circle.center - self).abs - circle.radius
    # diff < 0 ? 0 : diff
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
  alias parallel_to? parallel?

  def project(l)
    base = l.t - l.s
    r = (self - l.s).dot(base) / base.abs2
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
    return ONLINE_FRONT      if a.abs2     < b.abs2

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

  def rot90!
    @x, @y = -@y, @x
  end

  def rot(θ)
    Point.new(@x * cos(θ) - @y * sin(θ), @x * sin(θ) + @y * cos(θ))
  end
  alias rotate rot

  def rot!(θ)
    @x, @y = @x * cos(θ) - @y * sin(θ), @x * sin(θ) + @y * cos(θ)
  end
  alias rotate! rot!

  def polar
    Complex(@x, @y).polar
  end

  def flip!
    @x, @y = @y, @x
  end
  alias swap! flip!
  alias reverse! flip!

  def flip
    Point.new(@y, @x)
  end
  alias swap flip
  alias reverse flip

  def to_line
    Line.new(Point.origin, self)
  end
  alias to_segment to_line

  def origin?
    @x.abs < EPS && @y.abs < EPS
  end
  alias zero? origin?

  # def size
  #   2
  # end

  def to_a
    [@x, @y]
  end
  alias to_ary to_a

  # def to_c
  #   Complex(@x, @y)
  # end

  def [](i)
    case i
    when 0 then @x
    when 1, -1 then @y
    else
      raise ArgumentError
    end
  end

  def to_s
    # "#{@x.round(12)} #{@y.round(12)}" % [@x, @y]
    format("%f %f", @x, @y)
  end

  # def to_s; "#{x} #{y}" end
  def inspect
    format("(%f %f)", @x, @y)
  end

  def out
    puts "#{@x} #{@y}"
  end
  # deprecate
end

# Line
class Line
  def initialize(s, t)
    @s = s
    @t = t
  end
  attr_accessor :s, :t

  class << self
    # def gets
    #   s = Kernel.gets or return nil
    #   sx, sy, tx, ty = s.to_s.split.map{ |e| e.to_f }
    #   Line.new(Point.new(sx, sy), Point.new(tx, ty))
    # end

    def getf
      s = Kernel.gets or return nil
      sx, sy, tx, ty = s.to_s.split.map{ |e| e.to_f }
      Line.new(Point.new(sx, sy), Point.new(tx, ty))
    end

    def geti
      s = Kernel.gets or return nil
      sx, sy, tx, ty = s.to_s.split.map{ |e| e.to_i }
      Line.new(Point.new(sx, sy), Point.new(tx, ty))
    end
  end

  def orthogonal?(l)
    (@s - @t).dot(l.s - l.t).abs < EPS
  end

  def parallel?(l)
    (@s - @t).cross(l.s - l.t).abs < EPS
  end
  alias parallel_to? parallel?

  def project(v)
    base = @t - @s
    r = 1.0 * (v - @s).dot(base) / base.abs2
    @s + base * r
  end

  def reflect(v)
    v + (project(v) - v) * 2.0
  end

  def ccw(v)
    a = @t - @s
    b = v - @s
    return COUNTER_CLOCKWISE if a.cross(b) >  EPS
    return CLOCKWISE         if a.cross(b) < -EPS
    return ONLINE_BACK       if a.dot(b)   < -EPS
    return ONLINE_FRONT      if a.abs2     < b.abs2

    return ON_SEGMENT
  end

  def distance_to(other)
    case other
    when Point   then distance_to_point(other)
    when Segment then distance_to_segment(other)
    when Line    then distance_to_line(other)
    when Circle  then distance_to_circle(other)
    end
  end
  alias dist distance_to
  alias distance distance_to

  def distance_to_point(v)
    ((@t - @s).cross(v - @s) / (@t - @s).abs).abs
  end
  alias getDistanceLP distance_to_point

  def getDistanceSP(v)
    return (v - @s).abs if (@t - @s).dot(v - @s) < 0.0
    return (v - @t).abs if (@s - @t).dot(v - @t) < 0.0

    getDistanceLP(v)
  end

  def intersect?(l)
    ccw(l.s) * ccw(l.t) <= 0 && l.ccw(@s) * l.ccw(@t) <= 0
  end

  def intersect_to_circle?(c)
    distance_to_circle(c) < EPS
  end

  def distance_to_line(l)
    return 0.0 if intersect?(l)

    [
      getDistanceSP(l.s),
      getDistanceSP(l.t),
      l.getDistanceSP(@s),
      l.getDistanceSP(@t),
    ].min
  end
  # alias getDistance distance_to_line

  def distance_to_circle(c)
    pl = c.center.project(self)
    [(pl - c.c).abs - c.r, 0.0].min
  end

  def cross_point(l)
    base = @t - @s
    d1   = base.cross(l.t - l.s).abs
    d2   = base.cross(@t  - l.s).abs
    return l.s if d1.abs < EPS && d2.abs < EPS # same line!!
    return warn "!!!PRECONDITION NOT SATISFIED!!!" if d1.abs < EPS

    l.s + (l.t - l.s) * 1.0 * d2 / d1
  end
  # alias getCrossPoint cross_point

  def ==(other)
    @s == other.s && @t == other.t
  end

  def length
    Float::INFINITY
  end

  def slope
    dy = @t.y - @s.y
    dx = @t.x - @s.x

    dy / dx
  end

  def reverse
    self.class.new(@t, @s)
  end

  def reverse!
    @s, @t = @t, @s
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

# Segment
class Segment < Line
  def intersect?(other)
    ccw(other.s) * ccw(other.t) <= 0 && l.ccw(@s) * l.ccw(@t) <= 0
  end

  def distance_to(other)
    case other
    when Point   then distance_to_point(other)
    when Segment then distance_to_segment(other)
    when Line    then distance_to_line(other)
    when Circle  then distance_to_circle(other)
    end
  end
  # alias getDistance distance_to

  def distance_to_point(v)
    return (v - @s).abs if (@t - @s).dot(v - @s) < 0.0
    return (v - @t).abs if (@s - @t).dot(v - @t) < 0.0

    super
  end
  # alias getDistanceSP distance_to_point

  def distance_to_segment(other)
    return 0.0 if intersect?(other)

    [
      distance_to_point(other.s),
      distance_to_point(other.t),
      other.distance_to_point(@s),
      other.distance_to_point(@t),
    ].min
  end

  def distance_to_line(l)
    intersect?(l) ? 0.0 : [l.distance_to_point(@s), l.distance_to_point(@t)].min
  end

  def distance_to_circle(c)
    pc = c.center.project(self)
    t = [@s.dist(c.c), @t.dist(c.c)]
    t << @pc.dist(c.c) if ccw(pc).odd?
    [t.min - c.r, 0.0].max
  end

  def length
    (@t - @s).abs
  end
end

# Polygon
class Polygon
  def initialize(arg = nil)
    if block_given?
      @points = []
      arg.times{ @points << yield }
    else
      @points = arg || []
    end
  end
  attr_accessor :points

  extend Forwardable
  def_delegators(:@points, :push, :pop, :append, :prepend, :shift, :unshift, :size, :sort, :sort!, :sort_by, :sort_by!, :to_a, :uniq, :uniq!, :max_by, :max_by, :max, :min, :map)
  alias add_point push

  def area
    o = @points[-1]
    (0...@points.size - 1).sum{ |i| o.area(@points[i - 1], @points[i]) }.abs
  end

  def length
    (@points + @points[0]).each_cons(2).sum{ |x, y| (x - y).abs }
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

  def include?(v)
    # { ON_EDGE: 1, IN_POLYGON: 2, OUT_OF_POLYGON:0 }
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

  def ==(other)
    @points.sort == other.points.sort
  end

  def closest_pair
    # http://www.prefield.com/algorithm/geometry/closest_pair.html
    # pair<P,P> closestPair(vector<P> p) {
    #   int n = p.size(), s = 0, t = 1, m = 2, S[n]; S[0] = 0, S[1] = 1;
    #   sort(ALL(p)); // "p < q" <=> "p.x < q.x"
    #   double d = norm(p[s]-p[t]);
    #   for (int i = 2; i < n; S[m++] = i++) REP(j, m) {
    #     if (norm(p[S[j]]-p[i])<d) d = norm(p[s = S[j]]-p[t = i]);
    #     if (real(p[S[j]]) < real(p[i]) - d) S[j--] = S[--m];
    #   }
    #   return make_pair( p[s], p[t] );
    # }
    n = @points.size
    s = 0
    t = 1
    m = 2
    ss = Array.new(n)
    ss[0] = 0
    ss[1] = 1
    @points.sort!
    d = (@points[s] - @points[t]).abs2
    i = 2
    while i < n
      m.times do |j|
        if d > (@points[ss[j]] - @points[i]).abs2
          d = (@points[s = ss[j]] - @points[t = i]).abs2
        end
        if @points[ss[j]].x < @points[i].x - d
          ss[j] = ss[m -= 1]
          j -= 1
        end
      end
      ss[m] = i
      m += 1
      i += 1
    end

    [@points[s], @points[t]]
  end

  def andrew_scan
    g = Polygon.new
    g.points = @points.map(&:dup)
    g.andrew_scan!
  end

  def andrew_scan!
    u = Polygon.new
    l = Polygon.new
    return self if size < 3

    @points.sort!{ |a, b| (a.y <=> b.y).nonzero? || a.x <=> b.x }

    u.push(points[0], points[1])
    l.push(points[-1], points[-2])

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

    i = is
    j = js
    while true
      if (points[(i + 1) % n] - points[i]).cross(points[(j + 1) % n] - points[j]) >= 0
        j = (j + 1) % n
      else
        i = (i + 1) % n
      end
      d = (points[i] - points[j]).dist
      dmax = d if dmax < d
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
      q.push(cur) if ln.ccw(cur) != CLOCKWISE
      q.push(ln.cross_point(line(cur, nex))) if ln.ccw(cur) * ln.ccw(nex) < 0
    end
    q
  end

  def center_of_gravity
    # @points.sum(Point.new(0, 0)).fdiv(@points.size)
    @points.sum(Point.new(0, 0)).quo(@points.size)
  end

  def rhombus?
    size == 4 && @points.map{ |e| e.abs }.uniq.size == 1
  end

  def parallelogram?
    size == 4 && @points[0].parallel?(@points[2]) && @points[1].parallel?(@points[3])
  end

  def square?
    rhombus? && parallelogram?
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

# Triangle
class Triangle < Polygon
  def initialize(points = [])
    if block_given?
      3.times{ points << yield }
      @points = points
    else
      super
    end
  end

  class << self
    # def gets
    #   str = Kernel.gets or return nil
    #   a, b, c, d, e, f = str.split.map{ |e| e.to_f }
    #   Polygon.new([xy(a, b), xy(c, d), xy(e, f)])
    # end

    def getf
      str = Kernel.gets or return nil
      a, b, c, d, e, f = str.split.map{ |e| e.to_f }
      Polygon.new([xy(a, b), xy(c, d), xy(e, f)])
    end

    def geti
      str = Kernel.gets or return nil
      a, b, c, d, e, f = str.split.map{ |e| e.to_i }
      Polygon.new([xy(a, b), xy(c, d), xy(e, f)])
    end
  end

  def inradius
    @inradius or inscribed_circle and @inradius
  end

  def inner_center
    @inner_center or inscribed_circle and @inner_center
  end

  def inscribed_circle
    a, b, c = @points
    x = (b - c).abs
    y = (c - a).abs
    z = (a - b).abs
    @inner_center = (a * x + b * y + c * z) * 1.0 / (x + y + z)
    @inradius = area * 2.0 / (x + y + z)
    Circle.new(inner_center, inradius)
  end

  def circumradius
    a = (@points[1] - @points[0]).abs
    b = (@points[2] - @points[1]).abs
    c = (@points[0] - @points[2]).abs
    (a * b * c).fdiv(4 * area)
  end

  def circumcenter
    a, b, c = @points
    x = (b - c).abs2
    y = (c - a).abs2
    z = (a - b).abs2

    t = x * (y + z - x)
    u = y * (z + x - y)
    w = z * (x + y - z)

    (a * t + b * u + c * w).fdiv(t + u + w)

    # r = circumradius
    # ca = Circle.new(@points[0], r)
    # cb = Circle.new(@points[1], r)
    # cc = Circle.new(@points[2], r)
    # p0, p1 = ca.cross_points_to_circle(cb)
    # q0, q1 = ca.cross_points_to_circle(cc)
    # pp [ca.cross_points_to_circle(cb), ca.cross_points_to_circle(cc), cb.cross_points_to_circle(cc)]

    # return p0 if p0 == q0 || p0 == q1
    # return p1 if p1 == q0 || p1 == q1

    # raise "Triangle cannot find circumcenter"
  end

  def circumscribed_circle
    Circle.new(circumcenter, circumradius)
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
    def gets
      str = Kernel.gets or return nil
      cx, cy, r = str.to_s.split.map{ |e| e.to_f }
      Circle.new(Point.new(cx, cy), r)
    end

    def getf
      str = Kernel.gets or return nil
      cx, cy, r = str.to_s.split.map{ |e| e.to_f }
      Circle.new(Point.new(cx, cy), r)
    end

    def geti
      str = Kernel.gets or return nil
      cx, cy, r = str.to_s.split.map{ |e| e.to_f }
      Circle.new(Point.new(cx, cy), r)
    end

    def unit_ciercle
      Circle.new(Point.new(0.0, 0.0), 1.0)
    end
  end

  def diameter
    @r * 2
  end

  def length
    2 * @r * Math::PI
  end
  alias circumference length

  def area
    @r * @r * Math::PI
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

    return 0
  end
  alias number_of_common_tangents relation

  def intersection_to_line(l)
    warn "円と線は交わらない(接していない含む)" if @r < @c.distance_to_line(l)
    pr   = l.project(@c)
    e    = (l.t - l.s) / (l.t - l.s).abs # unit vector
    base = sqrt(@r * @r - (pr - c).abs2)
    t    = e * base
    [pr - t, pr + t] # .sort{ |a, b| (a.x <=> b.x).nonzero? || a.y <=> b.y }
  end
  alias cross_points_to_line intersection_to_line

  def cross_points_count(other)
    dc = @c.dist(other.c) # distance between centers

    lr, sr = @r, other.r
    lr, sr = sr, lr if lr < sr
    dr = lr - sr # diff between radiuses
    sr = lr + sr # sum of radiuses

    if dc < dr
      warn "Large circle contains small circle"
      0
    elsif dc == dr
      if dr == 0
        warn "Both circles are a perfect match: @c=#{@c.inspect}, @r=#{@r}"
        return Float::INFINITY
      end
      warn "One circle is inscribed inside another circle"
      1
    elsif dc > sr
      warn "Both circles don't intercect. 交点・接点はない"
      0
    elsif dc == sr
      1
    else
      2
    end
  end

  def intersection_to_circle(other)
    # 途中、螺旋本p.397
    d = @c.dist(other.c)

    lr, sr = @r, other.r
    lr, sr = sr, lr if lr < sr
    dr = lr - sr
    if d < dr
      warn "Large circle contains small circle"
    elsif d == dr
      if dr == 0
        warn "Both circles are a perfect match: @c=#{@c.inspect}, @r=#{@r}"
        return dup
      end
      warn "One circle is inscribed inside another circle"
    elsif d > @r + other.r
      warn "Both circles don't intercect. 交点・接点はない"
      return nil
    end

    a = Math.acos(Rational(@r * @r + d * d - other.r**2, 2.0 * @r * d))
    t = (other.c - @c).arg
    [Point.polar(r, t + a) + c, Point.polar(r, t - a) + c] # .sort{ |a, b| (a.x <=> b.x).nonzero? || a.y <=> b.y }
  end
  alias cross_points_to_circle intersection_to_circle

  def cross_points(other)
    case other
    when Line   then intersection_to_line(other)
    when Circle then intersection_to_circle(other)
    else raise ArgumentError end
  end
  # alias getCrossPoints cross_points
  alias intersectiton cross_points
  alias cross_points_to cross_points

  def contact_points_with_point(point)
    # https://ei1333.github.io/luzhiled/snippets/geometry/template.html
    # pair< Point, Point > tangent(const Circle &c1, const Point &p2)
    return cross_points_to_circle(Circle.new(point, Math.sqrt((@c - point).abs2 - @r * @r)))

    # refer to CGL_7_F code written by drken-san
    # http://judge.u-aizu.ac.jp/onlinejudge/review.jsp?rid=3140448#1
    d = (@c - point).abs2
    l = d - @r * @r
    return Point.new(0, 0) if l < -EPS

    l = 0.0 if l <= 0.0
    cq = (point - @c) * (@r * @r / d)
    qs = ((point - @c) * (@r * sqrt(l) / d)).rot90
    [@c + cq + qs, c + cq - qs] # .sort # { |a, b| (a.x <=> b.x).nonzero? || a.y <=> b.y }
  end
  # alias tangent contact_points_with_point

  def common_tangent_to_circle(other)
    # http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=CGL_7_G
    # common_tangent CGL_7_G
    tangents = []
    c1, c2 = self, other
    # if c1.r < c2.r
    #   c1, c2 = c2, c1
    #   # p "swap"
    # end
    g = (c1.c - c2.c).abs2
    return [] if g.abs < EPS

    u = (c2.c - c1.c) / Math.sqrt(g)
    v = u.rot(Math::PI * 0.5)

    [-1, 1].each do |s|
      h = (c1.r + s * c2.r) / Math.sqrt(g)
      if (1 - h * h).abs < EPS
        uu = h > 0 ? u : -u
        tangents.push(line(c1.c + uu * c1.r, c1.c + uu * c1.r + v))
      elsif 0 < 1 - h * h
        uu = u * h
        vv = v * Math.sqrt(1 - h * h)
        tangents.push(line(c1.c + (uu + vv) * c1.r, c2.c - (uu + vv) * c2.r * s))
        tangents.push(line(c1.c + (uu - vv) * c1.r, c2.c - (uu - vv) * c2.r * s))
        # p [c1.c + (uu + vv) * c1.r, c2.c - (uu + vv) * c2.r * s, c1.c + (uu - vv) * c1.r, c2.c - (uu - vv) * c2.r * s] # xoxo # xoxo
      end
    end
    tangents
  end

  def contact_points_with_polygon(other)
    # [TODO] http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=CGL_7_H
    # Intersection of a Circle and a Polygon CGL_7_H
  end

  def contact_points(other)
    case other
    when Point   then contact_points_with_point(other)
    when Circle  then contact_points_with_circle(other)
    when Polygon then contact_points_with_circle(other)
    else raise ArgumentError end
  end
  alias common_tangent contact_points

  def ==(other)
    @c.x - other.c.x < EPS && @c.y - other.c.y < EPS && @r - other.r < EPS
  end

  # https://ei1333.github.io/algorithm/geometry_new.html
  def area_of_intersection_with_circle(other)
    d = @c.dist(other.c)
    return 0.0 if d >= @r + other.r
    return (@r < other.r ? self : other).area if d <= (@r - other.r).abs

    # p1, p2 = cross_points(other)
    c1, c2 = self, other
    rc = (d * d + c1.r * c1.r - c2.r * c2.r) / (2 * d)
    θ = acos(rc / c1.r)
    φ = acos((d - rc) / c2.r)
    c1.r * c1.r * θ + c2.r * c2.r * φ - d * c1.r * sin(θ)
    # res -= (Triangle.new(@c, p1, p2).area + Triangle.new(other.c, p1, p2))
  end

  def contain_point?(point)
    @r * @r >= (point.x - c.x)**2 + (point.y - c.y)**2
  end

  def contain_polygon?(polygon)
    polygon.points.all?{ |point| ontain_point?(point) }
  end

  # def move(dx, dy)
  #   @c.x += dx
  #   @c.y += dy
  # end

  def to_a
    [@c.x, @c.y, @r]
  end

  def to_s
    "%f %f %f" % [@c.x, @c.y, @r]
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

def segment(a, b = nil, c = nil, d = nil)
  if b
    c ? Segment.new(xy(a, b), xy(c, d)) : Segment.new(a, b)
  else
    Segment.new(*a)
  end
end

def circle(x, y, r)
  Circle.new(Point.new(x, y), r)
end
alias Circle circle

def triangle(a, b = nil, c = nil, d = nil, e = nil, f = nil)
  res = Triangle.new
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

def polar(r, θ)
  # Point.new((Math.cos(θ) * r).round(13), (Math.sin(θ) * r).round(13))
  Point.new(Math.cos(θ) * r, Math.sin(θ) * r)
end

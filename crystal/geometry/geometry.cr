class Point
  EPS = 1e-10

  getter x : Float64
  getter y : Float64
  def initialize(@x = 0.0, @y = 0.0)
  end

  def self.getf
    str = gets || return nil
    x, y = str.split.map{ |t| t.to_f }
    Point.new(x, y)
  end

  def self.origin
    Point.new(0.0, 0.0)
  end

  def self.polar(r, θ)
    Point.new(Math.cos(θ) * r, Math.sin(θ) * r)
  end

  def +(other)
    Point.new(@x + other.x, @y + other.y)
  end

  def -(other)
    Point.new(@x - other.x, @y - other.y)
  end

  def *(k)
    Point.new(@x * k, @y * k)
  end

  def /(k)
    Point.new(@x / k, @y / k)
  end

  def dot(other : Point)
    @x * other.x + @y * other.y
  end

  def cross(other : Point)
    @x * other.y - @y * other.x
  end

  def abs2 : Float64
    @x * @x + @y * @y
  end

  def abs : Float64
    Math.sqrt(@x * @x + @y * @y)
  end

  def distance_to(other : Point) : Float64
    Math.hypot(@x - other.x, @y - other.y)
  end

  def to_a
    [@x, @y]
  end

  def origin?
    @x.abs < EPS && @y.abs < EPS
  end

  def to_line
    Line.new(Point.new(0.0, 0.0), self)
  end
end

class Line
  getter s : Point
  getter t : Point
  def initialize(@s, @t)
  end

  def orthogonal?(l : Line)
    (@s - @t).dot(l.s - l.t).abs < Point::EPS
  end

  def parallel?(l : Line)
    (@s - @t).cross(l.s - l.t).abs < Point::EPS
  end

  def project(v : Point)
    base = @t - @s
    r = 1.0 * (v - @s).dot(base) / base.abs2
    @s + base * r
  end

  def reflect(v : Point)
    v + (project(v) - v) * 2.0
  end

  def distance_to(v : Point)
    ((@t - @s).cross(v - @s) / (@t - @s).abs).abs
  end

  def distance_to(c : Circle)
    pl = c.center.project(self)
    [(pl - c.c).abs - c.r, 0.0].min
  end

  def intersect?(l : Line)
    ccw(l.s) * ccw(l.t) <= 0 && l.ccw(@s) * l.ccw(@t) <= 0
  end

  def intersect?(c : Circle)
    distance_to(c) < EPS
  end
end

o = Point.new
ex = Point.new(1.0, 0.0)
ey = Point.new(0.0, 1.0)
p o.abs
p o.distance_to(ex)

x = Line.new(o, ex)
p x.orthogonal?(x)
p x.parallel?(x)

# Point.getf

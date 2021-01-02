class Point(T)
  EPS = 1e-10
  include Math
  include Comparable(Point(T))

  def initialize(@x : T, @y : T)
  end
  property x : T, y : T

  def +(other)
    Point.new(@x + other.x, @y + other.y)
  end

  def -(other)
    Point.new(@x - other.x, @y - other.y)
  end

  def *(k)
    Point.new(@x / k, @y / k)
  end

  def /(k)
    Point.new(@x / k, @y / k)
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

  def abs2
    @x * @x + @y * @y
  end

  def abs
    sqrt(@x * @x + @y * @y)
  end

  def distance_to(other : Point)
    (other - self).abs
  end

  def distance_to(l : Line)
    b = l.t - l.s
    b.cross(self - l.s).abs / b.abs
  end

  def orthogonal?(other)
    dot(other).abs < EPS
  end

  def parallel?(other)
    cross(other).abs < EPS
  end

  def project(l : Line)
    base = l.t - l.s
    r = (self - l.s).dot(base) / base.abs2
    l.s + base * r
  end

  def reflect(l : Line)
    self + (project(l) - self) * 2
  end

  def to_a
    [@x, @y]
  end

  def to_s(io)
    io << "#{@x} #{@y}"
  end

  def inspect(io)
    io <<"(#{@x} #{@y})"
  end
end

puts Point.new(3.0, 4.0)
p Point.new(3.0, 4.0)
p Point.new(3.0, 4.0).abs2
p Point.new(3.0, 4.0).abs
p Point.new(0.0, 0.0) == Point.new(-0.0, -0.0)
p Point.new(0.0, 0.0) == Point.new(3.0, 4.0)

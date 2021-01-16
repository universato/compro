class Point
  getter x : Float64
  getter y : Float64
  def initialize(@x = 0.0, @y = 0.0)
  end

  def +(other)
    Point.new(@x + other.x, @y + other.y)
  end

  def +(other)
    Point.new(@x + other.x, @y + other.y)
  end

  def *(k)
    Point.new(@x * k, @y * k)
  end

  def /(k)
    Point.new(@x / k, @y / k)
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
end

class Line
  getter s : Point
  getter t : Point
  def initialize(@s, @t)
  end
end

o = Point.new
e = Point.new(1.0, 0.0)
p o.abs
p o.distance_to(e)

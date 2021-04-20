# Matrix
#
# Matrix.new(1, 2, 3, 4)
#   [[1, 2],
#    [3, 4]]
#
class Matrix
  class << self
    def rotation(theta)
      c = Math.cos(theta)
      s = Math.sin(theta)
      Matrix.new(c, -s, s, c)
    end

    def I(n)
      Matrix.new(1, 0, 0, 1)
    end
    alias identity I
    alias unit I
    alias eyes I

    def diagonal(x, w = x)
      Matrix.new(x, 0, 0, w)
    end

    def zeros
      Matrix.new(0, 0, 0, 0)
    end
    alias zeros zero

    def rot90
      Matrix.new(0, -1, 1, 0)
    end

    def clock90
      Matrix.new(0, 1, -1, 0)
    end

    def [](x, y, z, w)
      Matrix.new(x, y, z, w)
    end
  end

  def initialize(x, y, z, w)
    @x, @y, @z, @w = x, y, z, w
  end
  attr_reader :x, :y, :z, :w

  def *(v)
    Vector.new(x * v.x + y * v.y, z * v.x + w * v.y)
  end

  def diagonal?
    x == 0 && z == 0
  end

  def transpose
    Matrix.new(@x, @z, @y, @W)
  end

  def map
    Matrix.new(yield(x), yield(y), yield(z), yield(w))
  end

  def map!
    @x = yield(x)
    @y = yield(y)
    @z = yield(z)
    @w = yield(w)
  end
end

class Vector
  def initialize(x, y)
    @x = x
    @y = y
  end
  attr_reader :x, :y

  def +(other)
    Vector.new(x + other.x, y + other.y)
  end

  def -(other)
    Vector.new(x - other.x, y - other.y)
  end

  def *(k)
    Vector.new(x * k, y * k)
  end

  def /(k)
    Vector.new(x / k, y / k)
  end

  def ==(other)
    x == other.x && y == other.y
  end

  def map
    Vector.new(yield(x), yield(y))
  end

  def map!
    @x = yield(@x)
    @y = yield(@y)
  end

  def to_a
    block_given? ? [yield(x), yield(y)] : [x, y]
  end

  def rot90
    Vector.new(-y, x)
  end

  def clock90
    Vector.new(y, -x)
  end

  def rot(θ)
    Vector.new(@x * Math.cos(θ) - @y * Math.sin(θ), @x * Math.sin(θ) + @y * Math.cos(θ))
  end

  def reflect_x(s)
    Vector.new(2 * s - @x, @y)
  end

  def reflect_y(s)
    Vector.new(@x, 2 * s - @y)
  end

  class << self
    def geti
      x, y = gets.split.map{ |e| e.to_i }
      Vector.new(x, y)
    end

    def getf
      x, y = gets.split.map{ |e| e.to_f }
      Vector.new(x, y)
    end
  end
end

Math::TAU = Math::PI * 2

def abc189
  n = gets.to_s.to_i
  xys = Array.new(n){ gets.to_s.split.map{ |e| e.to_i } }.prepend(nil)

  m = gets.to_s.to_i
  ops = Array.new(m){ gets.to_s.split.map{ |e| e.to_i } }

  abs = []
  q = gets.to_s.to_i
  q.times{ abs.concat gets.to_s.split.map{ |e| e.to_i } }

  o = Vector.new(0, 0)
  ex = Vector.new(1, 0)
  ey = Vector.new(0, 1)

  mr90 = Matrix.clock90
  ml90 = Matrix.rot90

  os = [o]
  exs = [ex]
  eys = [ey]
  # p ops
  ops.each do |q, s|
    # q, s = gets.to_s.split.map{ |e| e.to_i }
    case q
    when 1
      o = mr90 * o
      ex = mr90 * ex
      ey = mr90 * ey
    when 2
      o = ml90 * o
      ex = ml90 * ex
      ey = ml90 * ey
    when 3
      o = o.reflect_x(s)
      ex = ex.reflect_x(s)
      ey = ey.reflect_x(s)
    when 4
      o = o.reflect_y(s)
      ex = ex.reflect_y(s)
      ey = ey.reflect_y(s)
    end
    os << o
    exs << ex
    eys << ey
  end

  abs.each_slice(2) do |a, b|
    x, y = xys[b]
    o = os[a]
    v = (exs[a] - o) * x + (eys[a] - o) * y + o
    puts "#{v.x} #{v.y}"
  end
end

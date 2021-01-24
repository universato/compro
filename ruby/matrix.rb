class Matrix
  class << self
    def rotation(theta)
      c = Math.cos(theta)
      s = Math.cos(theta)
      Matrix.new(c, -s, s, c)
    end

    def rot90
      Matrix.new(0, -1, 1, 0)
    end

    def clock90
      Matrix.new(0, 1, -1, 0)
    end
  end

  def initialize(x, y, z, w)
    @x, @y, @z, @w = x, y, z, w
  end
  attr_reader :x, :y, :z, :w

  def *(v)
    Vector.new(x * v.x + y * v.y, z * v.x + w * v.y)
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

  def rot90
    Vector.new(-y, x)
  end

  def clock90
    Vector.new(y, -x)
  end

  def reflect_x(s)
    Vector.new(2 * s - @x, @y)
  end

  def reflect_y(s)
    Vector.new(@x, 2 * s - @y)
  end
end

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

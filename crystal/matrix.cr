# [[x, y],
#  [w, z]]
class Matrix(T)
  property x : T
  property y : T
  property z : T
  property w : T
  def initialize(@x, @y, @z, @w)
  end

  def *(v : Vector)
    Vector(T).new(x * v.x + y * v.y, z * v.x + w * v.y)
  end
end

class Vector(T)
  property x : T
  property y : T
  def initialize(@x, @y)
  end
  def +(other : Vector)
    Vector(T).new(x + other.x, y + other.y)
  end
  def -(other : Vector)
    Vector(T).new(x - other.x, y - other.y)
  end
  def *(k)
    Vector(T).new(x * k, y * k)
  end
  def /(k)
    Vector(T).new(x / k, y / k)
  end
  def //(k)
    Vector(T).new(x // k, y // k)
  end
  def rot90
    Vector(T).new(-y, x)
  end
  def clock90
    Vector(T).new(y, -x)
  end
  def reflect_x(s)
    Vector(T).new(2i64 * s - x, y)
  end
  def reflect_y(s)
    Vector(T).new(x, 2i64 * s - y)
  end
end

def abc189
  n = gets.to_s.to_i
  xys = Array(Tuple(Int64, Int64)).new(n){ Tuple(Int64, Int64).from(gets.to_s.split.map{ |e| e.to_i64 }) }

  m = gets.to_s.to_i
  ops = Array.new(m){ gets.to_s.split.map{ |e| e.to_i64 } }

  abs = [] of Int64
  q = gets.to_s.to_i
  q.times{ abs.concat gets.to_s.split.map{ |e| e.to_i64 } }

  o = Vector(Int64).new(0_i64, 0_i64)
  ex = Vector(Int64).new(1_i64, 0_i64)
  ey = Vector(Int64).new(0_i64, 1_i64)

  mr90 = Matrix(Int64).new(0_i64, 1_i64, -1_i64, 0_i64)
  ml90 = Matrix(Int64).new(0_i64, -1_i64, 1_i64, 0_i64)

  os = [o]
  exs = [ex]
  eys = [ey]
  ops.each do |q|
    case q[0]
    when 1
      o = mr90 * o
      ex = mr90 * ex
      ey = mr90 * ey
    when 2
      o = ml90 * o
      ex = ml90 * ex
      ey = ml90 * ey
    when 3
      s = q[1]
      o = o.reflect_x(s)
      ex = ex.reflect_x(s)
      ey = ey.reflect_x(s)
    when 4
      s = q[1]
      o = o.reflect_y(s)
      ex = ex.reflect_y(s)
      ey = ey.reflect_y(s)
    end
    os << o
    exs << ex
    eys << ey
  end

  abs.each_slice(2) do |(a, b)|
    x, y = xys[b - 1]
    o = os[a]
    v = (exs[a] - o) * x + (eys[a] - o) * y + o
    puts "#{v.x} #{v.y}"
  end
end

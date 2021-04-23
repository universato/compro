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

    def I
      Matrix.new(1, 0, 0, 1)
    end
    alias identity I
    alias unit I
    alias eye I

    def diagonal(x, w = x)
      Matrix.new(x, 0, 0, w)
    end

    def zeros
      Matrix.new(0, 0, 0, 0)
    end
    alias zero zeros

    def ones
      Matrix.new(1, 1, 1, 1)
    end
    alias one ones

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

  def +(m)
    Matrix[x + m.x, y + m.y, z + m.z, w + m.w]
  end

  def -(m)
    Matrix[x - m.x, y - m.y, z - m.z, w - m.w]
  end

  def *(v)
    Vector.new(x * v.x + y * v.y, z * v.x + w * v.y)
  end

  def ==(m)
    @x == m.x && @y == m.y && @z == m.z && @w == m.w
  end
  alias eql? ==

  def diagonal?
    x == 0 && z == 0
  end

  def transpose
    Matrix.new(@x, @z, @y, @W)
  end
  alias t transpose

  def map
    Matrix.new(yield(x), yield(y), yield(z), yield(w))
  end
  alias collect map

  def map!
    @x = yield(x)
    @y = yield(y)
    @z = yield(z)
    @w = yield(w)
    self
  end
  alias collect! map!

  def row_vectors
    [Vector.new(@x, @y),
      Vector.new(@z, @w)]
  end

  def column_vectors
    [Vector.new(@x, @z), Vector.new(@y, @w)]
  end

  def determinant
    @x * @w - @y * @z
  end
  alias det determinant

  def trace
    @x + @w
  end
  alias tr trace

  def size
    2
  end
  alias length size
  alias column_size size
  alias column_count column_size
  alias row_size size
  alias row_count row_size

  def inverse
    det = @x * @w - @y * z
    Matrix.new(@z / det, -@y / det,
              -@w / det, @x / det)
  end
  alias inv inverse

  def adjugate
    Matrix.new(@z, -@y,
              -@w, @x)
  end
  alias adj adjugate

  def upper_triangular?
    @z == 0
  end

  def lower_triangular?
    @z == 0
  end

  def zero?
    @x == 0 && @y == 0 && @w == 0 && @z == 0
  end

  def square?
    true
  end

  def singular?
    @x * @w - @y * @z == 0
  end

  def symmetric?
    @y == @z
  end

  def [](i, j)
    if i == 0 || i == -2
      if j == 0 || j == -2
        @x
      elsif j == 1 || j == -1
        @y
      end
    elsif i == 1 || i == -1
      if j == 0 || j == -2
        @z
      elsif j == 1 || j == -1
        @w
      end
    end
  end

  def real
    Matrix.new(@x.real, @y.real, @z.real, @w.real)
  end

  def imaginary
    Matrix.new(@x.imaginary, @y.imaginary, @z.imaginary, @w.imaginary)
  end
  alias_method :imag, :imaginary

  def rect
    [real, imag]
  end
  alias_method :rectangular, :rect

  def sum
    @x + @y + @z + @w
  end

  def coerce(other)
    [self, other]
  end

  def number_of_nonzero
    nnz = 0
    nnz += 1 if @x != 0
    nnz += 1 if @y != 0
    nnz += 1 if @z != 0
    nnz += 1 if @w != 0
    nnz
  end
  alias nnz number_of_nonzero

  include Enumerable
  def each
    yield(@x); yield(@y)
    yield(@z); yield(@w)
    nil
  end

  def to_s
    "Matrix[#{@x}, #{@y},  #{@z}, #{@w}]"
  end
  alias inspect to_s
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

  def dot(other)
    @x * other.x + @y * other.y
  end
  alias inner_product dot

  def cross(other)
    @x * other.y - @y * other.x
  end
  alias cross_product cross

  include Comparable
  def <=>(other)
    (@x <=> other.x).nonzero? || @y <=> other.y
    # @x != other.x ? @x <=> other.x : @y <=> other.y
  end

  EPS = 1e-10
  def ==(other)
    x == other.x && y == other.y
    (@x - other.x).abs < EPS && (@y - other.y).abs < EPS
  end
  alias eql? ==

  include Enumerable
  def each
    yield(@x)
    yield(@y)
    nil
  end

  def map
    Vector.new(yield(x), yield(y))
  end

  def map!
    @x = yield(@x)
    @y = yield(@y)
    self
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

  def size
    2
  end
  alias length size

  def zero?
    @x = 0 && @y == 0
  end

  def [](i)
    if i == 0 || i == -2
      @x
    elsif i == 1 || i == -1
      @y
    else
      nil
    end
  end

  def sum
    @x + @y
  end

  def diff
    @x - @y
  end

  def last
    @y
  end

  def to_a
    [@x, @y]
  end

  def coerce(other)
    [self, other]
  end

  def clone
    Vector.new(@x, @y)
  end
  alias dup clone

  def number_of_nonzero
    nnz = 0
    nnz += 1 if @x != 0
    nnz += 1 if @y != 0
    nnz
  end
  alias nnz number_of_nonzero

  def to_s
    "Vector[#{@x}, #{@y}]"
  end
  alias inspect to_s

  class << self
    def [](x, y)
      Vector.new(x, y)
    end

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

if $0 == __FILE__
  p Vector.new(1, 2).eql? Vector.new(1, 2)
  # puts Vector.new(1, 2)
  # p Vector.new(1, 2)
  p Vector.new(100, 2).first
  Vector.new(1, 2).last

  p 2 * Vector.new(1, 2)
  p Vector.new(1, 2)
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

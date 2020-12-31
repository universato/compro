class Mint < Numeric
  attr_accessor :value, :mod

  @@mod = 10**9 + 7

  def initialize(value)
    @value = value
  end

  def +(other)
    case other
    when Mint
      Mint.new((value + other.value) % @@mod)
    when Integer
      Mint.new((value + other) % @@mod)
    else
      x, y = other.coerce(self)
      x + y
    end
  end

  def -(other)
    case other
    when Mint
      Mint.new((value - other.value) % @@mod)
    when Integer
      Mint.new((value - other) % @@mod)
    else
      x, y = other.coerce(self)
      x - y
    end
  end

  def *(other)
    case other
    when Mint
      Mint.new((value * other.value) % @@mod)
    when Integer
      Mint.new((value * other) % @@mod)
    else
      x, y = other.coerce(self)
      x * y
    end
  end

  def /(other)
    case other
    when Mint
      Mint.new((value * other.value.pow(@@mod - 2, @@mod) % @@mod))
    when Integer
      Mint.new((value * other.pow(@@mod - 2, @@mod) % @@mod))
    else
      x, y = other.coerce(self)
      x / y
    end
  end

  def %(other)
    case other
    when Mint
      raise MintDivisionError
    when Integer
      Mint.new(value % @@mod)
    else
      x, y = other.coerce(self)
      x % y
    end
  end

  def <=>(other)
    case other
    when Mint
      value % @@mod <=> other.value % @@mod
    when Integer
      value % @@mod <=> other % @@mod
    else
      x, y = other.coerce(self)
      x <=> y
    end
  end

  def coerce(other)
    case other
    when Integer
      return [Mint.new(other), self]
    when Mint
      return [other, self]
    else
      super
    end
  end

  def abs
    Mint.new(value % @@mod)
  end

  def inspect
    "#{value} (mod #{@@mod})"
  end

  def to_s
    (value % @@mod).to_s
  end

  def self.mod=(v)
    @@mod = v
  end

  def self.mod
    @@mod
  end
end

class MintDivisionError < StandardError
  def initialize(msg = "divided by Mint")
    super
  end
end

# class Integer

# def coerce(other)
#   if other.kind_of?(Mint)
#     return [other, Mint.new(self)]
#   elsif other.kind_of?(Integer)
#     return [other, self]
#   else
#     super
#   end
# end
# end

# class Range
#   alias_method :primitive_initialize, :initialize
#   def initialize(s,t)
#     s = s.value if s.kind_of?(Mint)
#     t = t.value if s.kind_of?(Mint)
#     primitive_initialize(s,t)
#   end
# end

# puts ans
# a= 1 + Mint.new(10**9+7)
# p Mint.new(10**9+7) + 1
# p Mint.new(10**9+7) + 1
# puts Mint.new(-6).abs

require 'minitest/autorun'

class MintExpendsNumeric_Test < Minitest::Test
  def test_new
    assert_equal 0, Mint.new(10**9 + 7)
    assert_equal 7, Mint.new(-10**9)
  end

  def test_plus
    r = rand(-10**20..10**20)
    assert_equal r % Mint.mod, Mint.new(0) + r
    assert_equal r % Mint.mod, r + Mint.new(0)
    assert_equal 0, Mint.new(10**9 + 7)
    assert_equal 1, Mint.new(10**9 + 7) + 1
    assert_equal 1, 1 + Mint.new(10**9 + 7)
    assert_equal 0, Mint.new(10**9 + 7)
  end

  def test_minus
    assert_equal 1, -(Mint.new(10**9 + 7) - 1)
    assert_equal 0, -Mint.new(10**9 + 7)
    assert_equal 10**9, 10**9 + 7 - Mint.new(7)
    assert_equal 0, 10**9 + 9 - Mint.new(2)
  end

  def test_equal
    m = 10**9 + 7
    r = rand(-10**20..10**20)
    assert Mint.new(10**9 + 7) == Mint.new(10**9 + 7)
    assert Mint.new(0) == Mint.new((10**9 + 7) * 2)
    assert Mint.new(3 * m + 10) == Mint.new(5 * m + 10)
    assert r % Mint.mod == Mint.new(r) + 0
    # assert_equal 0, 10**9+9-Mint.new(2)
  end
end

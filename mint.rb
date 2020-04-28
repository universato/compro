# MInt(ModInt)
class Integer

  attr_accessor :mod
  @@mod = 10 ** 9 + 7
  @@h = Hash.new

  def +@
    super % @@mod
  end

  def -@
    super % @@mod
  end

  alias_method :primitive_plus, :+
  def +(other)
    res = primitive_plus(other) % @@mod
  end

  alias_method :primitive_minus, :-
  def -(other)
    primitive_minus(other) % @@mod
  end

  alias_method :primitive_times, :*
  def *(other)
    self.primitive_times(other) % @@mod
  end

  #alias_method :primitive_div, :/
  def /(other)
    @@h[other] ||= other.pow(@@mod-2, @@mod)
    self * @@h[other]
  end

  alias_method :primitive_equal, :==
  def ==(other)
    ( self % @@mod ).primitive_equal( other % @@mod )
  end

  # def **(other)
  #   self.pow(other,@@mod)
  # end

  def abs
    self % @@mod
  end

  def <<(value)
    self * 2.pow(value, @@mod)
  end

  def >>(value)
    t = 2.pow(value, @@mod)
    @@h[t] ||= t.pow(@@mod-2, @@mod)
    self * @@h[t]
  end

  alias_method :primitive_inspect, :inspect
  def inspect
    self.primitive_inspect + " (mod #{@@mod.primitive_to_s})"
  end

  alias_method :primitive_to_s, :to_s
  def to_s
    (self % @@mod).primitive_to_s
  end
end

# ABC163
n, k = gets.to_s.split.map{|e|e.to_i}

ans = (k..n+1).map{|i| i * (n + n - i + 1) / 2 - i * ( i - 1 ) / 2 + 1 }.sum

puts ans
# p 1.class.instance_methods
# p 1.class.superclass.instance_methods

# require 'minitest/autorun'

# class Mint_Test < Minitest::Test

#   m = 10 ** 9 + 7
#   def test_plus
#     m = 10 ** 9 + 7
#     assert_equal 0, 1_000_000_007  + 0
#     assert_equal 0, 0 + 1_000_000_007
#     assert_equal 1, 1_000_000_007  + 1
#     assert_equal 1, 1 + 1_000_000_007
#     assert_equal 1, 2 + 1_000_000_006
#     assert_equal 1, 1_000_000_006  + 2
#     assert_equal 0, 1 + 1_000_000_006
#     assert_equal 0, 1_000_000_006 + 1
#     assert_equal 1, +1
#     assert_equal 0, +0
#   end
#   def test_minus
#     m = 10 ** 9 + 7
#     assert_equal 1_000_000_006, -1
#     assert_equal -1, 1_000_000_006
#     assert_equal 1_000_000_007, -0
#     assert_equal -(1_000_000_007), 0
#   end
#   def test_equal
#     m = 10 ** 9 + 7
#     assert 0 == 10 ** 9 + 7
#     assert 1 == 10 ** 9 + 8
#     assert 2 != 3
#     assert 50 * m == 30 * m
#   end
# end

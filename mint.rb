# MInt(ModInt)
class Integer

  attr_accessor :mod
  @@mod = 10 ** 9 + 7
  @@h = Hash.new

  alias_method :primitive_add, :+
  def +(other)
    self.primitive_add(other) % @@mod
    # res %= @@mod if res < 0 || res >= @@mod
    # res
  end

  alias_method :primitive_minus, :-
  def -(other)
    self.primitive_minus(other) % @@mod
    # res %= @@mod if res < 0 || res >= @@mod
    # res
  end

  alias_method :primitive_times, :*
  def *(other)
    self.primitive_times(other) % @@mod
  end

  def /(other)
    @@h[other] ||= other.pow(@@mod-2, @@mod)
    self * @@h[other] % @@mod
  end

  alias_method :primitive_inspect, :inspect
  def inspect
    (self % @@mod).primitive_inspect
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

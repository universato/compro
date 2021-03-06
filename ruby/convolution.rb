def convolution(a, b, k: 35, mod: 998244353, z: 99, r: 3)
  n = a.size
  m = b.size
  return [] if n == 0 || m == 0

  a_min, a_max = a.minmax
  b_min, b_max = b.minmax

  if a_min < 0 || b_min < 0
    raise ArgumentError
  end

  format = "%#{k.to_s.rjust(r, '0')}x".freeze # "%024x"
  sa = ""
  sb = ""
  a.each{ |x| sa << (format % x) }
  b.each{ |x| sb << (format % x) }

  zero = '0'.freeze
  s = zero * z + ("%x" % (sa.hex * sb.hex))
  i = -(n + m - 1) * k - 1
  return Array.new(n + m - 1){ (s[i + 1..i += k] || zero).hex % mod }

  s_size = s.size
  res = []
  i = 0
  t = n + m - 1
  while i < t
    j = k * i
    res << (s_size < j ? 0 : s[j...k+j].reverse.hex % mod)
    i += 1
  end
  res
end

def alpc
  n, m  = gets.to_s.split.map{ |e| e.to_i }
  a = gets.to_s.split.map{ |e| e.to_i }
  b = gets.to_s.split.map{ |e| e.to_i }
  puts convolution(a, b, k: 20)
end

def typical
  n = gets.to_s.to_i
  a, b = Array.new(n){ gets.to_s.split.map{ |e| e.to_i } }.transpose
  puts 0
  puts convolution(a, b, k: 8)
end

def convolution_naive(a, b, mod)
  n = a.size
  m = b.size
  c = [0] * (n + m - 1)
  n.times{ |i|
    m.times{ |j|
      c[i + j] += a[i] * b[j]
    }
  }
  return c.map{ |c| c % mod }
end

require "minitest"
require "minitest/autorun"

# [EXPERIMENTAL]
class ConvolutionMethodTest < Minitest::Test
  def test_typical_contest
    assert_equal [5, 16, 34, 60, 70, 70, 59, 36], convolution([1, 2, 3, 4], [5, 6, 7, 8, 9])
    assert_equal [871938225], convolution([10000000], [10000000])
  end

  def test_for_small_array
    assert_equal [1], convolution([1], [1])
    assert_equal [1, 2], convolution([1], [1, 2])
    assert_equal [1, 2], convolution([1, 2], [1])
    assert_equal [1, 4, 4], convolution([1, 2], [1, 2])
  end

  def test_random_array_modulo_default
    max_num = 10**18
    20.times{
      a = (0 .. 20).map{ rand(0 .. max_num) }
      b = (0 .. 20).map{ rand(0.. max_num) }
      assert_equal convolution_naive(a, b, 998_244_353), convolution(a, b)
    }
  end

  def test_random_array_modulo_NTT_friendly_given_proot
    max_num = 10**18
    [[  998_244_353,             5], # [mod, primitive_root]
     [  998_244_353,   100_000_005],
     [  998_244_353,   998_244_350],
     [1_012_924_417,             5],
     [1_012_924_417, 1_012_924_412],
     [  924_844_033,             5],
     [  924_844_033,   924_844_028]].each{ |mod, proot|
      20.times{
        a = (0 ... 20).map{ rand(0 .. max_num) }
        b = (0 ... 20).map{ rand(0 .. max_num) }
        assert_equal convolution_naive(a, b, mod), convolution(a, b, mod: mod)
      }
    }
  end

  def test_random_array_modulo_NTT_friendly_not_given_proot
    max_num = 10**18
    [998_244_353, 1_012_924_417, 924_844_033].each{ |mod|
      20.times{
        a = (0 ... 20).map{ rand(0 .. max_num) }
        b = (0 ... 20).map{ rand(0 .. max_num) }
        assert_equal convolution_naive(a, b, mod), convolution(a, b, mod: mod)
      }
    }
  end

  def test_random_array_small_modulo_limit_length
    max_num = 10**18
    [641, 769].each{ |mod|
      limlen = 1
      limlen *= 2 while (mod - 1) % limlen == 0
      limlen /= 2
      20.times{
        len_a = rand(limlen) + 1
        len_b = limlen - len_a + 1 # len_a + len_b - 1 == limlen
        a = (0 ... len_a).map{ rand(-max_num .. max_num) }
        b = (0 ... len_b).map{ rand(-max_num .. max_num) }
        a = (0 ... len_a).map{ rand(0 .. max_num) }
        b = (0 ... len_b).map{ rand(0 .. max_num) }
        assert_equal convolution_naive(a, b, mod), convolution(a, b, mod: mod)
      }
    }
  end

  def test_small_modulo_over_limit_length
    [641, 769].each{ |mod|
      limlen = 1
      limlen *= 2 while (mod - 1) % limlen == 0
      limlen /= 2
    }
  end
end

#  puts "hwloooooooooooooo"
# p (10**18).to_s(16)
# p "%020x" % (10**18)

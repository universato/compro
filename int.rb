class Integer

  # O(min(n-k,k) log m)
  # combination: nPk / k! (mod p), note: m must be a prime number
  def cmb(k, m=10**9+7)
    n = self
    return 0 if k < 0 || n < k
    k = n - k if k > n - k
    n.prm(k, m) * k.prm(k,m).modinv(m) % m
  end

  def hom(k, mod = 10**9+7)
    (self+k-1).cmb(k, mod)
  end

  # mod must be a prime number
  # O(log m)
  def modinv(mod = 10**9+7)
    pow(mod-2, mod)
  end

  # O(log n)
  # before Ruby 2.3
  def pow(n , mod = nil )
    a = self
    res = 1
    while n > 0
      if (n & 1) != 0
        res *= a
        res %= mod if mod
      end
      a *= a
      a %= mod if mod
      n >>= 1
    end
    res
  end

  # O(k)
  def prm(k, mod = nil)
    (0...k).reduce(1) do |res,i|
      res *= (self - i )
      res %= mod if mod
      res
    end
  end
end

# ABC145

require 'minitest/autorun'

class Facts_Test < Minitest::Test
  def test_pow
    assert_equal 1024, 2.pow(10)
    assert_equal 1024, 2.pow(10, 1_000_000_007)
  end
  def test_cmb
    assert_equal 1, 10.cmb(0)
    assert_equal 10, 10.cmb(1)
    assert_equal 45, 10.cmb(2)
    assert_equal 120, 10.cmb(3)
    assert_equal 1, 10.cmb(10)
    assert_equal 10, 10.cmb(9)
    assert_equal 45, 10.cmb(8)
    assert_equal 120, 10.cmb(7)
  end
  def test_modinv
    assert_equal 8, 5.modinv(13)
    assert_equal 4, 3.modinv(11)
    assert_equal 6, 2.modinv(11)
    assert_equal 3, 4.modinv(11)
    assert_equal 9, 5.modinv(11)
    assert_equal 8, 7.modinv(11)
  end
  def test_prm
    assert_equal 2, 2.prm(1)
    assert_equal 2, 2.prm(2)
    assert_equal 5, 5.prm(1)
    assert_equal 20, 5.prm(2)
    assert_equal 60, 5.prm(3)
    assert_equal 120, 5.prm(4)
    assert_equal 120, 5.prm(5)
  end
end

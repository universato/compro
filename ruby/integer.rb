class Integer
  # O(min(n-k,k) log m)
  # combination: nPk / k! (mod p), note: m must be a prime number
  def cmb(k, m = 10**9 + 7)
    n = self
    return 0 if k < 0 || n < k

    k = n - k if k > n - k
    n.prm(k, m) * k.prm(k, m).modinv(m) % m
  end
  alias binom cmb
  alias nCk cmb
  alias nCb cmb

  def hom(k, mod = 10**9 + 7)
    (self + k - 1).cmb(k, mod)
  end
  alias nHk hom

  # mod must be a prime number
  # O(log m)
  def modinv(mod = 10**9 + 7)
    pow(mod - 2, mod)
  end

  # O(log n)
  # before Ruby 2.3
  # def pow(n, mod = nil)
  #   a = self
  #   res = 1
  #   while n > 0
  #     if (n & 1) != 0
  #       res *= a
  #       res %= mod if mod
  #     end
  #     a *= a
  #     a %= mod if mod
  #     n >>= 1
  #   end
  #   res
  # end

  # O(k)
  def prm(k, mod = nil)
    (0...k).reduce(1) do |res, i|
      res *= (self - i)
      res %= mod if mod
      res
    end
  end
  alias nPk prm

  def divisible_by?(num)
    self % num == 0
  end
  alias has_divisor divisible_by?

  def divisor_of?(num)
    num % self == 0
  end

  # 約数列挙
  def divisors
    n = self #.abs
    s = Integer.sqrt(n)
    res1 = []
    res2 = []
    (1..s).each do |i|
      if self % i == 0
        res1 << i
        res2.unshift(n / i)
      end
    end
    res1.pop if s * s == n
    res1.concat(res2)
  end

  def each_divisor
    return enum_for(:each_divisor) unless block_given?

    s = Integer.sqrt(self)
    big_divisors = []
    (1..s).each do |i|
      if self % i == 0
        yield(i)
        big_divisors.unshift(self / i)
      end
    end
    big_divisors.shift if s * s == self
    big_divisors.each{ |d| yield(d) }
    nil
  end

  # 最下位ビットのみを立てた数
  def lsb
    self & -self
  end

  def popcount
    to_s(2).count('1')
  end
end

# ABC145

n = 100
p n.each_divisor
p n.each_divisor.to_a

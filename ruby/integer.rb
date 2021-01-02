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

  def popcount
    to_s(2).count('1')
  end
end

# ABC145

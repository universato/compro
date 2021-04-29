class Integer
  # O(min(n-k,k) log m)
  # combination: nPk / k! (mod p), note: m must be a prime number
  def comb(k, m = 10**9 + 7)
    n = self
    raise ArgumentError.new("self #{self} out of range (mod #{m})") if self >= m
    return 0 if k < 0 || n < k

    k = n - k if k > n - k
    n.prm(k, m) * k.prm(k, m).modinv(m) % m
  end
  alias binom comb
  alias nCk comb
  alias nCb comb
  alias cmb comb

  # O(1) nCk % 2 : nCk (mod 2)
  def comb_mod2(k)
    # allbits?(k) ? 1 : 0
    (self & k == k) ? 1 : 0
  end
  alias cmb_mod2 comb_mod2
  alias binom_mod2 comb_mod2

  def hom(k, mod = 10**9 + 7)
    (self + k - 1).comb(k, mod)
  end
  alias nHk hom

  # mod must be a prime number
  # O(log m)
  def modinv(mod = 10**9 + 7)
    pow(mod - 2, mod)
  end
  alias inv modinv

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

  # integer floor division
  def floor_div(other_int)
    self / other_int
  end
  alias fld floor_div
  # -Inf方向に丸める(Julia)

  # integer ceil division
  def ceil_div(other_int)
    (self + other_int - 1) / other_int
  end
  alias cld ceil_div

  def miman_div(other_int)
    # ceil_div(other_int) + 1
    # ((self + other_int - 1) / other_int) + 1
    (self - 1) / other_int
  end

  # 大半のケースは割れずに次にいくので、O(n)と考えてよさそう。
  def de_nankai_wareruka_hairetsu(n = 200_000)
    if self <= 1 || n < 0
      # 変化できなくなる回数と捉えれば、self==1は全て0が要素の配列を返すのが正しいかもしれない。
      raise ArgumentError.new('1以下は無理だし、配列は(0..n)でnは0以上を入れて欲しい')
    end

    (1..n).map do |i|
      cnt = 0
      while i % self == 0
        i /= self
        cnt += 1
      end
      cnt
    end.prepend(0)
  end

  # [0!, 1!, 2!, 3!, 4!, 5!, 6!, 7!, 8!, 9!, 10!, ……]が何回割れるか。
  def de_fact_wo_nankai_wareruka_hairetsu(n = 200_000)
    s = 0
    de_nankai_wareruka_hairetsu(n).map{ |k| s += k }
  end
  alias de_nankai_wareruka_hairetsu_fact de_fact_wo_nankai_wareruka_hairetsu

  def de_warikitta_amari_no_amari_hairetsu(n = 200_000)
    if self <= 1 || n < 0
      # 変化できなくなる回数と捉えれば、self==1は全て0が要素の配列を返すのが正しいかもしれない。
      raise ArgumentError.new('1以下は無理だし、配列は(0..n)でnは0以上を入れて欲しい')
    end

    (1..n).map do |i|
      i /= self while i % self == 0
      i % self
    end#.prepend(0)
  end

  # [0!, 1!, 2!, 3!, 4!, 5!, 6!, 7!, 8!, 9!, 10!, ……]を割った余り。
  def de_fact_wo_warikitta_kazu_no_amari_hairetsu(n = 200_000)
    r = 1
    de_warikitta_amari_no_amari_hairetsu(n).map{ |i| r = r * i % self }.prepend(0)
  end
end

if $0 == __FILE__ && true
  # ミスった。これはあまり意味がない配列の実験。
  p Array.new(10){ s *= (_1 + 1) } # => [1, 2, 6, 24, 120, 720, 5040, 40320, 362880, 3628800]
  p [1, 2, 6, 24, 120, 720, 5040, 40320, 362880, 3628800].map{ _1 % 2 } #=> [1, 0, 0, 0, 0, 0, 0, 0, 0, 0]
  p [1, 2, 6, 24, 120, 720, 5040, 40320, 362880, 3628800].map{ _1 % 3 } #=> [1, 2, 0, 0, 0, 0, 0, 0, 0, 0]
  p [1, 2, 6, 24, 120, 720, 5040, 40320, 362880, 3628800].map{ _1 % 4 } #=> [1, 2, 2, 0, 0, 0, 0, 0, 0, 0]
  p [1, 2, 6, 24, 120, 720, 5040, 40320, 362880, 3628800].map{ _1 % 5 } #=> [1, 2, 1, 4, 0, 0, 0, 0, 0, 0]
  p [1, 2, 6, 24, 120, 720, 5040, 40320, 362880, 3628800].map{ _1 % 6 } #=> [1, 2, 0, 0, 0, 0, 0, 0, 0, 0]
  p [1, 2, 6, 24, 120, 720, 5040, 40320, 362880, 3628800].map{ _1 % 7 } #=> [1, 2, 6, 3, 1, 6, 0, 0, 0, 0]
end

if $0 == __FILE__ && false
  n = 100_000
  m = 5
  p (0..n).map{ _1.ceil_div(m) - 1 } == (0..n).map{ _1.miman_div(m) }
end

if $0 == __FILE__ && false
  # (50, 18)  #=> 18,053,528,883,775
  p 50.comb(18)                      # => 528757404
  p 18_053_528_883_775 % (10**9 + 7) # => 528757404
  p 50.comb(18, 2) # => 0 誤ってる!
  # 誤ってるから、self 50 out of range (mod 2) (ArgumentError)にした。
end

if $0 == __FILE__ && false
  # (50, 18)  #=> 18,053,528,883,775
  p 50.comb(18)                      # => 528757404
  p 18_053_528_883_775 % (10**9 + 7) # => 528757404
  p 50.comb(18, 2) # => 0 誤ってる!
  # 誤ってるから、self 50 out of range (mod 2) (ArgumentError)にした。
end


if $0 == __FILE__ && false
  p (-5).floor_div 2 # => -3  # -2.5を -Inf方向に丸める。-Inf方向に丸める(Julia)
  p (-5).ceil_div 2  # => -2  # -2.5を +Inf方向に丸める。+Inf方向に丸める(Julia)

  p 5.koenai_div(2)  # => 2  # 2.5を未満の最大の整数は2
  p 10.koenai_div(2) # => 4  # 5を未満の最大の整数は4
  p 10.koenai_div(3) # => 3  # 3.333……を最大の整数は3
  p 0.koenai_div(1) # => 1  # 0未満の最大の整数は-1
  p 1.koenai_div(1) # => 0  # 1未満の最大の整数は0
  p 10.koenai_div(1) # => 9  # 10未満の最大の整数は9
end

# ABC145 ?

if $0 == __FILE__ && false
  n = 100
  p n.each_divisor
  p n.each_divisor.to_a
end

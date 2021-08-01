struct Int

  # O(min(n-k,k) log m)
  # combination: nPk / k! (mod p), note: m must be a prime number
  def cmb(k, m = 10**9 + 7)
    n = self
    return 0 if k < 0 || n < k
    k = n - k if k > n - k
    n.prm(k, m) * k.prm(k, m).modinv(m) % m
  end

  # mod must be a prime number
  # O(log m)
  def modinv(mod = 10**9 + 7)
    pow(mod - 2, mod)
  end

  # O(log n)
  def pow(n : Int, mod = nil ) : Int
    a = to_i64
    res = 1_i64
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
    (0...k).reduce(1_i64) do |res,i|
      res *= (self - i )
      res %= mod if mod
      res
    end
  end

  def prime?
    (2_i64).upto((self**0.5).floor){ |i| return false if self % i == 0 }
    self != 1
  end

  # 素因数分解
  def prime_factor : Hash(Int64, Int64)
    return Hash{1_i64 => 1_i64} if 1 == self
    # return Hash(Int64, Int64).new if 1 == self
    n = self.to_i64
    res = Hash(Int64, Int64).new(0_i64)
    (2_i64).upto((self**0.5).to_i64) do |i|
      while n % i == 0
        res[i] += 1_i64
        n = (n / i).to_i64
      end
    end
    res[n] = 1_i64 if n != 1
    res
  end

  # 素因数分解
  def prime_division : Array(Tuple(Int64, Int64))
    #return [{1_i64, 1_i64}] if 1 == self
    return Array(Tuple(Int64, Int64)).new if 1 == self
    n = self.to_i64
    res = Array(Tuple(Int64, Int64)).new
    (2_i64).upto((self**0.5).to_i64) do |i|
      t = 0_i64
      while n % i == 0
        t += 1_i64
        n = (n / i).to_i64
      end
      res.push({i, t}) if t != 0
    end
    res.push({n, 1_i64}) if n != 1_i64
    res
  end

  def bit_length
    n = self.abs
    res = 0
    while n > 0
      res += 1
      n //= 2
    end
    res
  end
end

require "spec"

describe Int do
  describe "#cmb" do
    it "is cpmbination of an integer" do
      10.cmb(0).should eq 1
      10.cmb(1).should eq 10
      10.cmb(2).should eq 45
      10.cmb(3).should eq 120
      10.cmb(7).should eq 120
      10.cmb(8).should eq 45
      10.cmb(9).should eq 10
      10.cmb(10).should eq 1
    end
  end

  describe "#modinv" do
    it "modular multiplicative inverse an integer" do
      5.modinv(13).should eq 8
      3.modinv(11).should eq 4
      2.modinv(11).should eq 6
      4.modinv(11).should eq 3
      5.modinv(11).should eq 9
      7.modinv(11).should eq 8
    end
  end

  describe "#pow" do
    it "is power of an integer" do
      2.pow(10).should eq 1024
      2.pow(10, 1_000_000_007).should eq 1024
    end
  end

  describe "#prime?" do
    it "is true if an integer is a prime number" do
      1.prime?.should be_false
      2.prime?.should be_true
      3.prime?.should be_true
      4.prime?.should be_false
      5.prime?.should be_true
      9.prime?.should be_false
      13.prime?.should be_true
      121.prime?.should be_false
    end
  end

  describe "#prime_factor" do
    it "is a prime factorization of an integer" do
      1.prime_factor.should eq Hash{1 => 1}
      25.prime_factor.should eq Hash{5 => 2}
      36.prime_factor.should eq Hash{2_i64 => 2, 3_i64 => 2}
      1_000_000_007.prime_factor.should eq Hash{1_000_000_007 => 1}
    end
  end

  describe "#prm" do
    it "is permutation of an integer" do
      2.prm(1).should eq 2
      2.prm(2).should eq 2
      5.prm(1).should eq 5
      5.prm(2).should eq 20
      5.prm(3).should eq 60
      5.prm(4).should eq 120
    end
  end

  describe "#bit_length" do
    it "bit_length" do
      0.bit_length.should eq 0
      1.bit_length.should eq 1
      2.bit_length.should eq 2
      3.bit_length.should eq 2
      4.bit_length.should eq 3
      5.bit_length.should eq 3
      7.bit_length.should eq 3
      8.bit_length.should eq 4
    end
  end
end

# p 5.divisors
# p 100.divisors

# pow
# https://atcoder.jp/contests/jsc2021/tasks/jsc2021_d

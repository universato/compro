struct Int

  # combination: nPk / k! (mod p), note: m must be a prime number
  def cmb(k, m=10**9+7)
    n = self
    k = n - k if k > n - k
    n.prm(k, m) * k.prm(k,m).modinv(m) % m
  end
  # mod must be a prime number
  def modinv(mod = 10**9+7)
    pow(mod-2, mod)
  end
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

  def prm(k, m = nil)
    (0...k).reduce(1_i64) do |res,i|
      res *= (self - i )
      res %= m if m
      res
    end
  end

  def prime_factor : Hash(Int64, Int64)
    return Hash{1_i64 => 1_i64} if 1 == self
    n = self.to_i64
    res = Hash(Int64, Int64).new(0_i64);
      (2_i64).upto((self**0.5).to_i64) do |i|
      while n % i == 0
        res[i] += 1_i64
        n = (n / i).to_i64
      end
    end
    res[n] = 1_i64 if n != 1
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
  describe "#prime_factor" do
    it "is a prime factorization of an integer" do
      1.prime_factor.should eq Hash{1 => 1}
      25.prime_factor.should eq Hash{5 => 2}
      36.prime_factor.should eq Hash{2_i64 => 2, 3_i64 => 2}
      # 1_000_000_007.prime_factor.should eq Hash{1_000_000_007 => 1}
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
end

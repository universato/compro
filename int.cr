struct Int
  def pow(n : Int, mod = nil ) : Int
    a = self
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
end

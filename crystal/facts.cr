class Facts
  def initialize(mod : (Int64|Int32) = 10**9+7, n_max : (Int64|Int32) = 1_i64 )
    @mod = mod
    @n_max = n_max
    @fact = [1_i64, 1_i64]
    @inv = [0_i64, 1_i64]
    @factinv = [1_i64, 1_i64]
    setup_table(n_max) if 1 < @n_max
  end

  def cmb(n,r)
    return 0 if (r < 0 || n < r)
    setup_table(n) if @n_max < n
    @fact[n] * (@factinv[r] * @factinv[n-r] % @mod) % @mod
  end

  def factorial(n)
    setup_table(n) if @n_max < n
    @fact[n]
  end

  def hom(n,k)
    cmb(n+k-1, k)
  end

  def prm(n,k)
    setup_table(n) if @n_max < n
    @fact[n] * @factinv[n-k] % @mod
  end

  # O(t - @n_max)
  private def setup_table(t)
    (@n_max+1).upto(t) do |i|
      @fact.push( @fact[-1] * i % @mod )
      @inv.push( -@inv[@mod % i] * (@mod // i) % @mod )
      @factinv.push( @factinv[-1] * @inv[-1] % @mod )
    end
    @n_max = t
  end
end

# ABC145
# ABC156 Roaming 2020/5/11 AC ver 0.20
# ABC167 E - Colorful Blocks 2020/5/11

require "spec"

describe Facts do
  describe "#cmb" do
    it "is cpmbination of arguments" do
      f = Facts.new
      f.cmb(10,-1).should eq 0
      f.cmb(10,0).should eq 1
      f.cmb(10,1).should eq 10
      f.cmb(10,2).should eq 45
      f.cmb(10,8).should eq 45
      f.cmb(10,9).should eq 10
      f.cmb(10,10).should eq 1
      f.cmb(10,11).should eq 0
    end
  end
  describe "#factorial" do
    it "is factorial of an integer" do
      f = Facts.new
      f.factorial(0).should eq 1
      f.factorial(1).should eq 1
      f.factorial(2).should eq 2
      f.factorial(3).should eq 6
      f.factorial(4).should eq 24
      f.factorial(5).should eq 120
    end
  end
  describe "#prm" do
    it "is permutation of arguments" do
      f = Facts.new
      f.prm(5,0).should eq 1
      f.prm(5,1).should eq 5
      f.prm(5,2).should eq 20
      f.prm(5,3).should eq 60
      f.prm(5,4).should eq 120
      f.prm(5,5).should eq 120
    end
  end
end

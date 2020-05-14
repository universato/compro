class Facts

  def initialize(mod=10**9+7, n_max=1)
    @mod = mod
    @n_max = n_max
    @fact = [1, 1]
    @inv = [0,1]
    @factinv = [1, 1]
    setup_table(n_max) if 1 < @n_max
  end

  def cmb(n,r)
    return 0 if r < 0 || n < r
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

  private
    # O(t)
    def setup_table(t)
      (@n_max+1).upto(t) do |i|
        @fact.push( @fact[-1] * i % @mod )
        @inv.push( -@inv[@mod % i] * (@mod / i) % @mod )
        @factinv.push( @factinv[-1] * @inv[-1] % @mod )
      end
      @n_max = t
    end
end

# ABC132 Blue and Red Balls 2020/5/13 hom  nHk
# ABC145 2020/5/6
# ABC156 Roaming 2020/5/11 AC
# ABC167 E - Colorful Blocks 2020/5/11 AC

# ABC156 Roaming 2020/5/11 AC
# mod = 10 ** 9 + 7

# n, k = gets.to_s.split.map{|t|t.to_i}

# ans = 0
# f = Facts.new

# if n <= k
#   puts f.hom(n, n)
#   puts "a"
#   exit
# end

# 0.upto([n-1, k].min) do |i|
#   ans += f.cmb(n, i) * f.hom(n-i, i)
#   ans %= mod if ans >= mod
# end

# puts ans

require 'minitest/autorun'

class Facts_Test < Minitest::Test
  def test_cmb
    f = Facts.new
    assert_equal 0, f.cmb(10,-1)
    assert_equal 1, f.cmb(10,0)
    assert_equal 10, f.cmb(10,1)
    assert_equal 45, f.cmb(10,2)
    assert_equal 120, f.cmb(10,3)
    assert_equal 120, f.cmb(10,7)
    assert_equal 45, f.cmb(10,8)
    assert_equal 10, f.cmb(10,9)
    assert_equal 1, f.cmb(10,10)
    assert_equal 0, f.cmb(10,11)
    assert_equal f.cmb(500,100), f.cmb(500,400)
    assert_equal f.cmb(1000,100), f.cmb(1000,900)
  end
  def test_factorial
    f = Facts.new
    assert_equal 1, f.factorial(0)
    assert_equal 1, f.factorial(1)
    assert_equal 2, f.factorial(2)
    assert_equal 6, f.factorial(3)
    assert_equal 24, f.factorial(4)
    assert_equal 120, f.factorial(5)
    assert_equal 720, f.factorial(6)
  end
  def test_hom
    mod = 10 ** 9 + 7
    f = Facts.new
    assert_equal 607923868, f.hom(200000,1000000000)
    n = rand(1..100)
    k = n + rand(1..100)
    assert_equal f.hom(n,n), (0..k).reduce(0){|s,i|s += f.cmb(n, i) * f.hom(n-i, i) % mod } % mod
  end
  def test_prm
    f = Facts.new
    assert_equal 1, f.prm(5,0)
    assert_equal 5, f.prm(5,1)
    assert_equal 20, f.prm(5,2)
    assert_equal 60, f.prm(5,3)
    assert_equal 120, f.prm(5,4)
    assert_equal 120, f.prm(5,5)
  end
end

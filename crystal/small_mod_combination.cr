class SmallModCombination
  def initialize(n = 200_000, mod = 3)
    @f = [0]; cumsum = 0;
    @g = [1]; remainder = 1;

    (1..n).each do |i|
      cnt = 0
      while i % mod == 0
        i //= mod
        cnt += 1
      end
      @f << (cumsum += cnt)
      @g << (remainder = remainder * i % mod)
    end
  end

  def nCr_mod3(n, r)
    return 1 if r == 0 || r == n
    return 0 if @f[n] - @f[r] - @f[n - r] > 0

    @g[r] * @g[n - r] == 2 ? 3 - @g[n]: @g[n]
  end

  def self.comb_mod2(n, k)
    (n & k == k) ? 1 : 0
  end
end

class Facts
  def initialize(mod = 10**9 + 7, n_max = 1)
    @mod = mod
    @n_max = n_max
    @fact = [1, 1]
    @inv = [0, 1]
    @factinv = [1, 1]
    setup_table(n_max) if 1 < @n_max
  end

  def comb(n, r)
    return 0 if r < 0 || n < r

    setup_table(n) if @n_max < n
    @fact[n] * (@factinv[r] * @factinv[n - r] % @mod) % @mod
  end
  alias binom comb # LaTex
  alias nCk comb
  alias nCr comb
  alias cmb comb
  # alias nchoosek comb # MATLAB

  def factorial(n)
    setup_table(n) if @n_max < n
    @fact[n]
  end

  # nHk
  def hom(n, k)
    comb(n + k - 1, k)
  end
  alias nHk hom

  def prm(n, k)
    setup_table(n) if @n_max < n
    @fact[n] * @factinv[n - k] % @mod
  end
  alias nPk prm

  def catalan_number(n)
    comb(2 * n, n) * @inv[n + 1] % @mod
  end

  private

  # O(t)
  def setup_table(t)
    (@n_max + 1).upto(t) do |i|
      @fact.push(@fact[-1] * i % @mod)
      @inv.push(-@inv[@mod % i] * (@mod / i) % @mod)
      @factinv.push(@factinv[-1] * @inv[-1] % @mod)
    end
    @n_max = t
  end
end

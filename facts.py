class Facts:

  def __init__(self, mod=10**9+7, n_max=1):
    self.mod     = mod
    self.n_max   = n_max
    self.fact    = [1, 1]
    self.inv     = [0, 1]
    self.factinv = [1, 1]
    if 1 < n_max:
      self.setup_table(n_max)

  def cmb(self, n, r):
    if r < 0 or n < r:
      return 0
    if self.n_max < n:
      self.setup_table(n)
    return self.fact[n] * (self.factinv[r] * self.factinv[n-r] % self.mod) % self.mod

  def factorial(self, n):
    if self.n_max < n:
      self.setup_table(n)
    return self.fact[n]

  def hom(self, n, k):
    return self.cmb(n+k-1, k)

  def prm(self, n, k):
    if self.n_max < n:
      self.setup_table(n)
    return self.fact[n] * self.factinv[n-k] % self.mod

  def setup_table(self, t):
    for i in range(self.n_max+1,t+1):
      self.fact.append( self.fact[-1] * i % self.mod )
      self.inv.append( -self.inv[mod % i] * (self.mod // i) % self.mod )
      self.factinv.append( self.factinv[-1] * self.inv[-1] % self.mod )
    self.n_max = t

# ABC156 Roaming
# Python3(3.4.3) 688ms
# PyPy3 241ms
mod = 10 ** 9 + 7

n, k = map(int, input().split())

ans = 0
f = Facts(mod)

for i in range(0, min(n-1, k)+1):
  ans += f.cmb(n,i) * f.hom(n-i,i) % mod
  if ans >= mod:
    ans -= mod

print(ans)

# ABC167 E 2020/5/11
# mod = 998244353

# n, m, k = map(int, input().split())

# ans = 0
# f = Facts(mod)
# t = m * pow(m-1, n-1-k, mod)

# for i in range(k,-1,-1):
#   ans += f.cmb(n-1,i) * t % mod
#   t = t * (m-1) % mod

# print(ans % mod)

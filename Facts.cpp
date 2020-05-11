// Facts.cpp
#include <iostream>
#include <vector>
using namespace std;

class Facts
{
public:
    long long mod = 1000000007;
    int n_max = 1;
    vector<long long int>  fact{1, 1};
    vector<long long int>  inv{1, 1};
    vector<long long int>  factinv{1, 1};

    Facts();
    Facts(int64_t mod);
    int64_t cmb(int n, int r);
    int64_t hom(int n, int r);
    void setup_table(int t);
};

Facts::Facts(int64_t m){
  mod = m;
}

int64_t Facts::cmb(int n, int r){
  if(r < 0 || n < r) return 0;
  if(n_max < n) setup_table(n);
  return fact[n] * (factinv[r] * factinv[n-r] % mod) % mod;
}

int64_t Facts::hom(int n, int r){
  return Facts::cmb(n+r-1, r);
}

void Facts::setup_table(int t){
  for(int i=n_max+1; i<=t; i++){
    fact.push_back( fact.back() * i % mod );
    inv.push_back( -inv[mod % i] * (mod / i) % mod );
    factinv.push_back( factinv.back() * inv.back() % mod );
  }
  n_max = t;
}

long long modpow(long long a, long long n, long long mod) {
    long long res = 1;
    while (n > 0) {
        if (n & 1) res = res * a % mod;
        a = a * a % mod;
        n >>= 1;
    }
    return res;
}

// a^{-1} mod を計算する
long long modinv(long long a, long long mod) {
    return modpow(a, mod - 2, mod);
}

// ABC156 E - Roaming 2020/5/11/ AC 29ms
int main(){

  int64_t mod = 1000000007;

  int64_t n, k;
  cin >> n >> k;

  int64_t ans = 0;
  Facts f = Facts(mod);

  for(int i=0; i<=min(n-1,k); i++){
    ans += f.cmb(n, i) * f.hom(n-i,i) % mod;
    if(ans<0) ans += mod;
  }

  cout << ans % mod << "\n";
  return 0;
}

// int main(){

//   int64_t mod = 998244353;

//   int64_t n, m, k;
//   cin >> n >> m >> k;

//   int64_t ans = 0, t;
//   Facts f = Facts(mod);
//   t = m * modpow(m-1, n-1-k, mod) % mod;

//   for(int i=k; i>=0; i--){
//     ans += f.cmb(n-1, i) * t % mod;
//     ans %= mod;
//     t = t * (m-1) % mod;
//   }

//   if(ans < 0) ans += mod;
//   cout << ans << "\n";
//   return 0;
// }

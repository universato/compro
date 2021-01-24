#include <iostream>
#include <vector>
#include <numeric>
using namespace std;

template <typename T> long long sum(T &a){
  long long res = 0LL;
  for (auto& k : a) { res += k; }
  return res;
}

double sum(std::vector<double> &a){
  double res = 0.0;
  for (auto& k : a) { res += k; }
  return res;
}

template <typename T, typename M> M sum(T &a, M mod){
  long long res = 0LL;
  for (auto& k : a) { res = (res + k) % mod; }
  if (mod < 0){ res += mod; }
  return res;
}

template <typename T> long long prod(T &a){
  long long res = 1LL;
  for (auto& k : a) { res *= k; }
  return res;
}

template <typename T, typename M> long long prod(T &a, M mod){
  long long res = 1LL;
  for (auto& k : a) { res = (res * k) % mod; }
  if (mod < 0){ res += mod; }
  return res;
}

// 値渡しだと、めちゃくちゃ遅いらしい。
// 引数にもループにもつけたらいいのかな。ループは不要そうな感じもする。
// 参照渡しで、渡す。仮引数に`&`をつけるだけ。

// std::accumulateを使うには、#include <numeric>をする。

int main(){
  std::vector<long long> a = {1LL, 2LL, 3LL, 4LL, 5LL};
  std::cout << sum(a) << std::endl;
  std::cout << std::accumulate(a.begin(), a.end(), 0LL) << std::endl;


  std::vector<int> b = {1, 2, 3, 4, 5};
  std::cout << sum(b) << std::endl;
  std::cout << std::accumulate(b.begin(), b.end(), 0LL) << std::endl;

  std::vector<double> c = {0.1, 0.2, 0.3, 0.4, 0.5};
  std::cout << sum(c) << std::endl;
  std::cout << std::accumulate(c.begin(), c.end(), 0.0) << std::endl;

  std::cout << sum(a, 10) << std::endl;
  std::cout << sum(b, 10) << std::endl;
  std::cout << prod(a) << std::endl;
  std::cout << prod(b) << std::endl;
  std::cout << prod(a, 11) << std::endl;
  std::cout << prod(b, 11) << std::endl;
}

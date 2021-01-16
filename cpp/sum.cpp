#include <iostream>
#include <vector>
#include <numeric>
using namespace std;

long long sum(std::vector<long long> &a){
  long long res = 0;
  for (auto k : a) { res += k; }
  return res;
}

long long sum(std::vector<int> &a){
  long long res = 0;
  for (auto k : a) { res += k; }
  return res;
}

// 値渡しだと、めちゃくちゃ遅いらしい。
// 参照渡しで、渡す。仮引数に`&`をつけるだけ。

// std::accumulateを使うには、#include <numeric>をする。

int main(){
  std::vector<long long> a = {0LL, 1LL, 2LL};
  std::cout << sum(a) << std::endl;
  std::cout << std::accumulate(a.begin(), a.end(), 0LL) << std::endl;

  std::vector<int> b = {0, 1, 2};
  std::cout << sum(b) << std::endl;
  std::cout << std::accumulate(b.begin(), b.end(), 0LL) << std::endl;
}

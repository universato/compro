#include <iostream>
#include <vector>
#include <limits>
using namespace std;

long long max(std::vector<long long> &a){
  long long res = std::numeric_limits<long long>::min();
  for (auto k : a) { res = (res > k ? res : k); }
  return res;
}

int max(std::vector<int> &a){
  long long res = std::numeric_limits<int>::min();
  for (auto k : a) { res = (res > k ? res : k); }
  return res;
}

long long min(std::vector<long long> &a){
  long long res = std::numeric_limits<long long>::max();
  for (auto k : a) { res = (res < k ? res : k); }
  return res;
}

int min(std::vector<int> &a){
  long long res = std::numeric_limits<int>::max();
  for (auto k : a) { res = (res < k ? res : k); }
  return res;
}

double max(std::vector<double> &a){
  double res = std::numeric_limits<double>::min();
  for (auto k : a) { res = (res > k ? res : k); }
  return res;
}

double min(std::vector<double> &a){
  double res = std::numeric_limits<double>::max();
  for (auto k : a) { res = (res < k ? res : k); }
  return res;
}

// 最大値・最小値に#include <limits>を用いている。

// 値渡しだと、めちゃくちゃ遅いらしい。
// 参照渡しで、渡す。仮引数に`&`をつけるだけ。

int main(){
  std::vector<long long> a = {0LL, 1LL, 2LL};
  std::cout << max(a) << std::endl;
  std::cout << min(a) << std::endl;

  std::vector<int> b = {0, 1, 2};
  std::cout << max(b) << std::endl;
  std::cout << min(b) << std::endl;

  std::vector<double> c = {0.0, 1.0, 2.0};
  std::cout << max(c) << std::endl;
  std::cout << min(c) << std::endl;
}

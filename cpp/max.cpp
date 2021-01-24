#include <iostream>
#include <vector>
#include <limits>
// using namespace std;

template <typename T> T max(std::vector<T> &a){
  T res = std::numeric_limits<T>::min(); // #include <limits>
  for (auto& k : a) { res = (res > k ? res : k); }
  return res;
}

template <typename T> T min(std::vector<T> &a){
  T res = std::numeric_limits<T>::max();
  for (auto& k : a) { res = (res < k ? res : k); }
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

  std::vector<double> c = {0.0, 0.1, 0.2, 0.15};
  std::cout << max(c) << std::endl;
  std::cout << min(c) << std::endl;
}

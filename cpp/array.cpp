#include <iostream>
#include <vector>
using namespace std;

template <typename T> std::vector<T> reverse(std::vector<T> &a){
  std::reverse(a.begin(), a.end());
  return a;
}

template <typename T> std::vector<T> sort(std::vector<T> &a){
  std::sort(a.begin(), a.end());
  return a;
}

template <typename T> T find(std::vector<T> &a, T c){
  auto itr = std::find(a.begin(), a.end(), c);
  return itr == a.end() ? -1 : *itr;
}

template <typename T> T find_index(std::vector<T> &a, T c){
  auto itr = std::find(a.begin(), a.end(), c);
  return itr == a.end() ? -1 : distance(a.begin(), itr);
  // return itr == a.end() ? -1 : itr - a.begin();
}

int main(){
  std::vector<int> a = {10, 20, 30, 40, 50};

  std::cout << find(a, 10) << '\n';
  std::cout << find(a, 20) << '\n';
  std::cout << find(a, 30) << '\n';
  std::cout << find(a, 0) << '\n';
  std::cout << find(a, 100) << '\n';

  std::cout << find_index(a, 10) << '\n';
  std::cout << find_index(a, 20) << '\n';
  std::cout << find_index(a, 30) << '\n';
  std::cout << find_index(a, 0) << '\n';
  std::cout << find_index(a, 100) << '\n';

  reverse(a);
  for (auto k : a) { std::cout << k << ' '; };
  std::cout << '\n';

  std::vector<long long> b = {1LL, 2LL, 3LL};
  reverse(b);
  for (auto k : b) { std::cout << k << ' '; };
  std::cout << '\n';

  std::vector<double> c = {1.5, 2.5, 3.5};
  reverse(c);
  for (auto k : c) { std::cout << k << ' '; };
  std::cout << '\n';

  // vector<int> x = {100, 200, 300, 400, 500};
  // int t = find(x.begin(), x.end(), 0) - x.begin();
  // cout << t << '\n';
}

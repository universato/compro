#include <iostream>
#include <vector>
// using namespace std;

// template <typename T> void put(std::vector<T>& a) {
//   int _n = a.size() - 1;
//   for(int i = 0; i < _n; i++){ std::cout << a[i] << ' '; }
//   std::cout << a[_n] << '\n';
// }

template <typename T> void put(std::vector<T>& a) {
  for(auto it = a.begin(); it < a.end() - 1; it++){ std::cout << *it << ' '; }
  std::cout << a.back() << '\n';
}

template <typename T> void puts(std::vector<T>& a) {
  for(auto& k : a) std::cout << k << '\n';
}

template <typename T> void pp(std::vector<std::vector<T> >& graph) {
  for(auto& list : graph){ put(list); }
}

int main() {
  std::vector<int> a = {1, 2, 3};
  put(a);
  puts(a);

  std::vector<long long> b = {1LL, 2LL, 3LL};
  put(b);
  puts(b);

  std::vector<std::string> s = {"hello,", "world!"};
  put(s);
  puts(s);

  std::vector<char> c = {'a', 'b', 'c'};
  put(c);
  puts(c);

  std::vector<std::vector<int> > mi = {{1, 2}, {3, 4}};
  pp(mi);

  std::vector<std::vector<long long> > m = {{1, 2}, {3, 4}};
  pp(m);

  std::vector<std::vector<double> > md = {{0.1, 0.2}, {0.3, 0.4}};
  pp(md);
}

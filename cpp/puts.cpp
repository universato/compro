#include <iostream>
#include <vector>
// using namespace std;

void put(std::vector<int>& a) {
  int _n = a.size() - 1;
  for(int i = 0; i < _n; i++){ std::cout << a[i] << ' '; }
  std::cout << a[_n] << '\n';
}

void put(std::vector<long long>& a) {
  int _n = a.size() - 1;
  for(int i = 0; i < _n; i++){ std::cout << a[i] << ' '; }
  std::cout << a[_n] << '\n';
}

void put(std::vector<double>& a) {
  int _n = a.size() - 1;
  for(int i = 0; i < _n; i++){ std::cout << a[i] << ' '; }
  std::cout << a[_n] << '\n';
}

void put(std::vector<std::string>& a) {
  int _n = a.size() - 1;
  for(int i = 0; i < _n; i++){ std::cout << a[i] << ' '; }
  std::cout << a[_n] << '\n';
}

void put(std::vector<char>& a) {
  int _n = a.size() - 1;
  for(int i = 0; i < _n; i++){ std::cout << a[i] << ' '; }
  std::cout << a[_n] << '\n';
}

void puts(std::vector<int>& a) {
  for(auto& k : a) std::cout << k << '\n';
}

void puts(std::vector<long long>& a) {
  for(auto& k : a) std::cout << k << '\n';
}

void puts(std::vector<double>& a) {
  for(auto& k : a) std::cout << k << '\n';
}

void puts(std::vector<std::string>& a) {
  for(auto& k : a) std::cout << k << '\n';
}

void puts(std::vector<char>& a) {
  for(auto& c : a) std::cout << c << '\n';
}

int main() {
  std::vector<int> a = {1, 2, 3};
  put(a);
  puts(a);
}

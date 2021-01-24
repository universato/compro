// trash
// ゴミ箱

#include <iostream>
#include <vector>
#include <limits>
using namespace std;

// template関数で、まとめたので不要。
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

// array.cppにいれてたreverse。テンプレート関数にまとめたので不要。
std::vector<int> reverse(std::vector<int> &a){
  std::reverse(a.begin(), a.end());
  return a;
}

std::vector<long long> reverse(std::vector<long long> &a){
  std::reverse(a.begin(), a.end());
  return a;
}

std::vector<double> reverse(std::vector<double> &a){
  std::reverse(a.begin(), a.end());
  return a;
}

// sumもテンプレート関数でまとめたので不要。
long long sum(std::vector<long long> &a){
  long long res = 0;
  for (auto& k : a) { res += k; }
  return res;
}

long long sum(std::vector<int> &a){
  long long res = 0;
  for (auto& k : a) { res += k; }
  return res;
}

// テンプレート関数にまとめたので不要
template <typename T> void pp(std::vector<std::vector<T> >& graph) {
  for(auto& list : graph){
    for(auto& node : list){
      std::cout << node << " ";
    }
    std::cout << '\n';
  }
}

テンプレート関数にまとめたので不要
void pp(std::vector<std::vector<long long> >& graph) {
  for(auto& list : graph){
    for(auto& node : list){
      std::cout << node << " ";
    }
    std::cout << '\n';
  }
}

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

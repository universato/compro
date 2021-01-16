#include <iostream>
#include <vector>
using namespace std;

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

int main(){
  std::vector<int> a = {1, 2, 3};
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
}

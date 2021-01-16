#include <bits/stdc++.h>
#include <boost/multiprecision/cpp_int.hpp>

int main(){
  using namespace std;
  boost::multiprecision::cpp_int N;
  cin >> N;
  cout << N * (N + 1) / 2 << "\n";
}

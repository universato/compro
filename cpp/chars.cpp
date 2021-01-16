#include <iostream>
#include <vector>
using namespace std;

std::vector<char> chars1(string s){
  int n = s.size();
  std::vector<char> res;
  for (int i = 0; i < n; i++) { res.push_back(s[i]); }
  return res;
}

std::vector<char> chars2(string s){
  int n = s.size();
  std::vector<char> res(n);
  for (int i = 0; i < n; i++) { res[i] = s[i]; }
  return res;
}

std::vector<char> chars(string s){
  std::vector<char> res;
  for (auto c : s) { res.push_back(c); }
  return res;
}

// Rubyのcharsメソッドを再現したかった。
// 配列とかのサイズはintで収まると思うのでこれで良い。
int main(){
  string s = "hello";
  int n = s.size();

  std::vector<char> a = chars(s);

  for (int i = 0; i < n; i++) {
    cout << a[i] << " ";
  }
}

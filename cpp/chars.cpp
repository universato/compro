#include <iostream>
#include <vector>
using namespace std;

std::vector<char> chars(string s){
  int n = s.size();
  std::vector<char> res(n);
  for (int i = 0; i < n; i++) { res[i] = s[i]; }
  return res;
}

// Rubyのcharsメソッドを再現したかった。
// 配列とかのサイズはintで収まると思うのでこれで良い。
int main(){
  string s = string(100000000, '.');
  int n = s.size();

  std::vector<char> a = chars1(s);

  for (int i = 0; i < n; i++) {
    //cout << a[i] << " ";
  }
}

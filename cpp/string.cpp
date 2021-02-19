#include <iostream>
#include <string>

std::string upcase(std::string &s){
  std::transform(s.begin(), s.end(), s.begin(), ::toupper);
  return s;
}

std::string downcase(std::string &s){
  std::transform(s.begin(), s.end(), s.begin(), ::tolower);
  return s;
}

std::string capitalize(std::string &s){
  std::transform(s.begin(), s.end(), s.begin(), ::tolower);
  s[0] -= 32;
  return s;
}

std::string swapcase(std::string &s){
  for(auto &c : s){ c ^= 32; }
  return s;
}

std::string swapcase2(std::string &s){
  for(auto &c : s){
    if ('a' <= c && c <= 'z'){ c -= 32; }
    else if('A' <= c && c <= 'Z'){ c += 32; }
  }
  return s;
}

std::string reverse(std::string &s){
  std::reverse(s.begin(), s.end());
  return s;
}

int ord(char c){ return c - 0; }
char chr(int d){ return d - 0; }

// std::upperでもupperでも動かず、::upperで動く。謎。
//
// https://stackoverflow.com/questions/16792456/no-matching-function-for-call-to-transform
// `::toupper`だけだと不十分な可能性があって、キャスト(?)した方がいいらしい。
// static_cast<int(*)(int)>(::toupper)

int main(){
    std::cout << 'a' - 'A' << '\n'; // 32

    std::string s = "aBC3_defG";
    std::cout << s << std::endl;
    std::cout << downcase(s) << std::endl;
    std::cout << upcase(s) << std::endl;
    std::cout << capitalize(s) << std::endl;
    std::cout << swapcase(s) << std::endl;
    std::cout << reverse(s) << std::endl;
    std::cout << ord('a') << std::endl;
    std::cout << ord('A') << std::endl;
    std::cout << chr(97) << std::endl;
    std::cout << chr(65) << std::endl;
}

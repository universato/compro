// tsでも普通に動いた。
function pow(k, n, mod) {
  let a = k;
  let res = 1;
  while(n > 0){
    if((n & 1) != 0){
      res *= a;
      if(mod) res %= mod;
    }
    a *= a;
    if(mod){ a %= mod; }
    n >>= 1;
  }
  return res;
}

console.log(pow(2, 4, 9));
console.log(pow(2, 10, 1000));
console.log(pow(2, 10, 1000000007));

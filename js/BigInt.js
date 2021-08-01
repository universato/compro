BigInt.prototype.pow = function(x, m) {
  if(m === 1n){ return 0n; }

  let r = 1n;
  let y = x % m;
  while(n > 0n){
    if(n % 2n == 1n){
      r = r * y % m;
    }
    y = y * y % m
    n >>= 1n
  }
  return (r + m) % m
}

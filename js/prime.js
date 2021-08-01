Number.prototype.divisors = function() {
  let n = this
  s = Math.sqrt(n)
  let res1 = []
  let res2 = []
  for(let i = 1; i <= s; i++){
    if(n % i === 0){
      res1.push(i);
      res2.unshift(n / i);
    }
  }
  if(s * s == n){
    res1.pop();
  }
  return res1.concat(res2);
}

function newtonIterationForBigIntSqrt(n, x0) {
  const x1 = ((n / x0) + x0) >> 1n;
  if (x0 === x1 || x0 === (x1 - 1n)) { return x0; }
  return newtonIterationForBigIntSqrt(n, x1);
}

// https://stackoverflow.com/questions/53683995/javascript-big-integer-square-root
BigInt.prototype.sqrt = function() {
  if (this < 0n) { throw 'square root of negative numbers is not supported' }
  if (this < 2n) { return this; }
  return newtonIterationForBigIntSqrt(this, 1n);
}

BigInt.prototype.divisors = function() {
  let n = this
  s = n.sqrt();
  let res1 = []
  let res2 = []
  for(let i = 1n; i <= s; i++){
    if(n % i === 0n){
      res1.push(i);
      res2.unshift(n / i);
    }
  }
  if(s * s == n){
    res1.pop();
  }
  return res1.concat(res2);
}

let n
n = 10n;
// n = 25n;
console.log(n.divisors())

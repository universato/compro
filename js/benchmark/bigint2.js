const { PerformanceObserver, performance } = require('perf_hooks');

// 文字列から数値への置換
// Number() >>>>>>>> BigInt()

// main
// setup
const n = 1 * 10**7;

numbers = [...Array(n).keys()]
bigints = numbers.map((n) => BigInt(n))

Array.prototype.sum = function() {
  // typeof arg === "number"
  return this.reduce((total, num) => total + num);
  return this.reduce((total, num) => { return total + num; }, 0);
}

// console.log(renban);

// benchmark
const t0 = performance.now();
x = numbers.sum()

const t1 = performance.now();
y = bigints.sum()


const t2 = performance.now();


const t3 = performance.now();
// y = renban.map((n) => parseInt(n, 10))

// const t4 = performance.now();

// output
put_diff(t0, t1);
put_diff(t1, t2);
put_diff(t2, t3);
// put_diff(t3, t4);

assert_equal(x, y);
// console.log([x, y])
// assert_equal_array(x, y)
// assert_equal_array(y, z)
// assert_equal_array(y, renban)

function put_diff(st, end) {
  let d = end - st;
  console.log(Math.round(d) + " ms");
}

function assert_equal(x, y) {
  if(x === y){ console.log(true); return true; }
  else{ console.log(false); return false }
}

function assert_equal_array(a1, a2) {
  let n = a1.length
  let m = a2.length
  if(n !== a2.length){ console.log(`false: size different ${n} and ${m}`); return false; }
  for(let i = 0; i < n; i++) {
    if (a1[i] !== a2[i]){ console.log(`false: element different ${a1[i]} ${a2[i]}`); return false; }
  }

  console.log(true);
  return true;
}

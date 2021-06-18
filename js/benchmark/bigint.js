const { PerformanceObserver, performance } = require('perf_hooks');

// 文字列から数値への置換
// Number() >>>>>>>> BigInt()

// main
// setup
const n = 1 * 10**7;

numbers = [...Array(n).keys()]
renban = numbers.map((n) => n.toString())

// console.log(renban);

// benchmark
const t0 = performance.now();
renban.forEach((n) => Number(n))

const t1 = performance.now();
renban.forEach((n) => BigInt(n))


const t2 = performance.now();


const t3 = performance.now();
// y = renban.map((n) => parseInt(n, 10))

// const t4 = performance.now();

// output
put_diff(t0, t1);
put_diff(t1, t2);
put_diff(t2, t3);
// put_diff(t3, t4);

// assert_equal_array(x, y)
// assert_equal_array(y, z)
// assert_equal_array(y, renban)

function put_diff(st, end) {
  let d = end - st;
  console.log(Math.round(d) + " ms");
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

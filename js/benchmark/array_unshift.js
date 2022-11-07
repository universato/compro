const { PerformanceObserver, performance } = require('perf_hooks');

// const n = 2 * 10**5;
const n = 20000;
a = []
b = []

const t0 = performance.now();

for(let i = 0; i < n; i++){ a.push(0) }

const t1 = performance.now();

for(let i = 0; i < n; i++){ b.unshift(0) }

const t2 = performance.now();

// 出力
console.log("n = " + n)
process.stdout.write("push    :  ")
console.log(Math.round(t1 - t0) + " ms");
process.stdout.write("unshift :  ")
console.log(Math.round(t2 - t1) + " ms");

// output
// put_diff(t0, t1);
// put_diff(t1, t2);
// put_diff(t2, t3);
// put_diff(t3, t4);

assert_equal_array(a, b)
// assert_equal_array(y, z)
// assert_equal_array(y, renban)

function put_diff(st, end) {
  const d = end - st;
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

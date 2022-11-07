const { PerformanceObserver, performance } = require('perf_hooks');

const n = 5 * 10**5;
a = []
b = []

const t0 = performance.now();

for(let i = 0; i < n; i++){ a.push(i) }
for(let i = 0; i < n; i++){ a.pop() }

const t1 = performance.now();

for(let i = 0; i < n; i++){ b.unshift(i) }
for(let i = 0; i < n; i++){ b.shift() }

const t2 = performance.now();
const t3 = performance.now();

// output
put_diff(t0, t1);
put_diff(t1, t2);
// put_diff(t2, t3);
// put_diff(t3, t4);

assert_equal_array(a, b)
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

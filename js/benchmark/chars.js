const { PerformanceObserver, performance } = require('perf_hooks');

// chars
// split('')の方が大きくなると速い。2 * 10**6ぐらいでかなり差がでてくる。
// 拡張した場合は変わらないかな。

// main
// setup
const n = 2 * 10**6;
s = "abcdefghijklmnopqrstuvwxyz".repeat(n);
// console.log(s)

function chars1(str){ return str.split(''); }
function chars2(str){ return Array.from(str); }
String.prototype.chars = function() {
  return this.split('');
}

// console.log(renban);

// benchmark
const t0 = performance.now();
// x = chars2(s)

const t1 = performance.now();
// y = chars1(s)

const t2 = performance.now();
x = s.chars()

const t3 = performance.now();
const t4 = performance.now();

// output
put_diff(t0, t1);
put_diff(t1, t2);
put_diff(t2, t3);
// put_diff(t3, t4);

// assert_equal_array(x, y)
// assert_equal_array(y, z)

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

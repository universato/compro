const { PerformanceObserver, performance } = require('perf_hooks');

// 連番の配列の作成
// [Qiita: JavaScriptで\[ 0, 1, 2, 3, 4 \]のような連番の配列を生成する方法](https://qiita.com/suin/items/1b39ce57dd660f12f34b)
// forで作った方が圧倒的に速い。
// keysを使った方法は、簡単だけど遅さが目立つ。


// main

// setup
const n = 10**7;

function renban(st, n) {
  if(n === undefined){
    n = st;
    st = 0;
  }
  a = new Array(n);
  for(let i = st; i < n; i++){ a[i] = i; }
  return a;
}

// benchmark
const t0 = performance.now();

x = [...Array(n)].map((_, i) => i);

const t1 = performance.now();

y = [...Array(n)].reduce((p, c, i, a) => ((a[i] = i), a), 0);

const t2 = performance.now();

z = renban(n);
// z = [...Array(n).keys()];

const t3 = performance.now();

// output
put_diff(t0, t1);
put_diff(t1, t2);
put_diff(t2, t3);

assert_equal_array(x, y)
assert_equal_array(y, z)

function put_diff(st, end) {
  let d = end - st;
  console.log(Math.round(d) + " ms");
}

function assert_equal_array(a1, a2) {
  let n = a1.length
  if(n !== a2.length){ console.log(false); return false; }
  for(let i = 0; i < n; i++) {
    if (a1[i] !== a2[i]){ console.log(false); return false; }
  }

  console.log(true);
  return true;
}

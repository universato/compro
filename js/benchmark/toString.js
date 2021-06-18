const { PerformanceObserver, performance } = require('perf_hooks');

// 数値から文字列への置換
// forEachに変更して計測したら、どれが速いってことはない気がした。
// [要検討] toFixed は未検討。toFixedも文字列に変換する。

// main
// setup
const n = 10**7;
numbers = [...Array(n).keys()]

// console.log(renban);

// benchmark
const t0 = performance.now();
// y = renban.map((n) => +n)
y = numbers.forEach((n) => n + "")


const t1 = performance.now();


z = numbers.forEach((n) => "" + n)

const t2 = performance.now();
x = numbers.forEach((n) => n.toString())


const t3 = performance.now();
w = numbers.forEach((n) => String(n))

const t4 = performance.now();

// output
put_diff(t0, t1);
put_diff(t1, t2);
put_diff(t2, t3);
put_diff(t3, t4);

// assert_equal_array(x, y)
// assert_equal_array(y, z)
// assert_equal_array(z, w)
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

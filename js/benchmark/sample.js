const { PerformanceObserver, performance } = require('perf_hooks');

// main

const n = 10**5;


var t0 = performance.now();

// for(let i = 0; i < n; i++){
//   ""
// }

var t1 = performance.now();

for(let i = 0; i < n; i++){

}

var t2 = performance.now();


// output
put_diff(t0, t1);
put_diff(t1, t2);

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

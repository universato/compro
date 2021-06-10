function floor_sum(n, m, a, b) {
  let ans = 0n;
  if (a >= m) {
      ans += (n - 1n) * n * (a / m) / 2n;
      a %= m;
  }
  if (b >= m) {
      ans += n * (b / m);
      b %= m;
  }

  let y_max = (a * n + b) / m, x_max = (y_max * m - b);
  if (y_max == 0n) return ans;
  ans += (n - (x_max + a - 1n) / a) * y_max;
  ans += floor_sum(y_max, a, m, (a - x_max % a) % a);
  return ans;
}

module.exports = floor_sum;

// console.log(floor_sum(4n, 10n, 6n, 3n));

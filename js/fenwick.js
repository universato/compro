class FenwickTree {
  constructor(n = 0) {
    this.n = n
    this.data = new Array(n + 1).fill(0);
  }
  add(p, x) {
    p++;
    while (p <= this.n) {
      this.data[p - 1] += x;
      p += (p & -p);
    }
  }
  sum(l, r) {
    return this._sum(r) - this._sum(l);
  }
  _sum(r) {
    let s = 0;
    while (r > 0) {
      s += this.data[r - 1];
      r -= (r & -r);
    }
    return s;
  }
}

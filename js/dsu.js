class DSU {
  constructor(n = 0) {
    this.parent_or_size = new Array(n).fill(-1);
  }

  merge(a, b) {
    let x = this.leader(a);
    let y = this.leader(b);
    if (x === y) return x;

    if (-this.parent_or_size[x] < -this.parent_or_size[y]) [x, y] = [y, x]
    this.parent_or_size[x] += this.parent_or_size[y];
    this.parent_or_size[y] = x;
    return x;
  }

  leader(a) {
    if (this.parent_or_size[a] < 0) return a;
    return this.parent_or_size[a] = this.leader(this.parent_or_size[a]);
  }

  same(a, b) {
    return this.leader(a) === this.leader(b);
  }

  size(a) {
    return -this.parent_or_size[this.leader(a)];
  }
}

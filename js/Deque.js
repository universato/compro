class Deque {
  constructor(arg = []) {
    let initial_capacity = 500_000;
    let ary = arg;
    this.n = Math.max(initial_capacity, ary.length) + 1;
    this.buf = ary.concat(new Array(this.n - ary.length));
    this.head = 0;
    this.tail = ary.length
    this.reverseCount = 0n
  }
  to_a() {
    return this.#to_a();
  }
  #to_a(s = this.head, t = this.tail) {
    if(s < 0){ s += this.n }
    if(t < 0){ t += this.n }
    let res = s <= t ? this.buf.slice(s, t) : this.buf.slice(s, this.n).concat(this.buf.slice(0, t));
    return this.isReversed() ? res.reverse() : res;
  }
  isReversed() {
    return this.reverseCount % 2n == 1n
  }
  push(x) {
    return this.isReversed() ? this.#unshift(x) : this.#push(x);
  }
  unshift(x) {
    return this.isReversed() ? this.#push(x) : this.#unshift(x);
  }
  #push(x) {
    if(this.#isFull()){ this.#extend() }
    this.buf[this.tail] = x
    this.tail += 1
    this.tail %= this.n
    return this
  }
  #unshift(x) {
    if(this.#isFull()){ this.#extend() }
    let index = (this.head - 1) % this.n;
    if(index < 0){ index += this.n }
    this.buf[index] = x
    this.head -= 1
    this.head %= this.n
    return this
  }
  pop() {
    return this.isReversed() ? this.#shift() : this.#pop();
  }
  shift(x) {
    return this.isReversed() ? this.#pop() : this.#shift();
  }
  #pop() {
    if(this.isEmpty()){ return undefined }
    let index = (this.tail - 1) % this.n
    if(index < 0){ index += this.n; }
    let ret = this.buf[index];
    this.tail -= 1;
    this.tail %= this.n
    if(this.tail < 0){ this.tail += this.n }
    return ret;
  }
  #shift() {
    if(this.isEmpty()){ return undefined }
    if(this.head < 0){ this.head += this.n; }
    let ret = this.buf[this.head];
    this.head += 1;
    this.tail %= this.n
    return ret;
  }
  #isFull() {
    return this.size() >= this.n - 1
  }
  size() {
    return (this.tail - this.head) % this.n
  }
  swap(_i, _j) {
    let i = this.#index(_i)
    let j = this.#index(_j)
    let tmp = this.buf[i];
    this.buf[i] = this.buf[j];
    this.buf[j] = tmp;
    // [this.buf[i], this.buf[j]] = [this.buf[j], this.buf[i]]
    return this;
  }
  isEmpty() {
    return this.size() === 0;
  }
  #extend() {
    if(this.tail + 1 === this.head) {
      tail = this.buf.shift(this.tail + 1);
      this.buf.concat(tail).concat([undefined] * this.n)
      this.head = 0
      this.tail = n - 1
      this.n = this.buf.length
    } else {
      // [WIP]
      this.buf
      this.n = this.buf.length
      if(this.head > 0){ this.head += this.n }
    }
  }
  #index(i) {
    let l = this.size();
    if(this.isReversed()){ i = -(i + 1); }
    if(i < 0){ i = -(i + 1); }
    let index = (this.head + i) % this.n;
    if(index < 0){ index += this.n; }
    return index;
  }
  reverse() {
    this.reverseCount += 1n;
    return this;
  }
}

d = new Deque([1, 2, 3])
d.push(4);
d.push(6);
d.unshift(99);
// d.unshift(98);
// console.log(d)
// console.log(d.size())
// console.log(d.to_a())
// console.log(typeof d.to_a())

module.exports = Deque;

"use strict";

function isArray(obj){ return Array.isArray(obj); }
function isEmptyArray(ary) { return ary.length === 0; }
function prod(numbers) { return numbers.reduce((res, num) => { return res * num; }, 1); }
function sum(numbers) { return numbers.reduce((total, num) => { return total + num; }, 0); }
function uniq(numbers) { return Array.from(new Set(numbers)); }

Array.prototype.isBalanced = function(index) {
  if (this.length & 1 == 1){ return false; }

  let balance = 0
  this.foEach((k) => {
    balance += k
    if(balance < 0){ return false; }
  })
  return balance == 0
}

Array.prototype.delete_at = function(index) {
  return this.splice(index, 1);
}

Array.prototype.dup = function() {
  return this.concat();
}

Array.prototype.equals = function(other) {
  if (this.length !== other.length) {
    return false
  }

  let n = this.length;
  for(let i = 0; i < n; i++){
    if(this[i] !== other[i]) {
      return false
    }
  }

  return true;
}

Array.prototype.first = function() {
  return this[0];
}

Array.prototype.isArray = function() {
  return true;
}

Array.prototype.isEmpty = function() {
  return this.length === 0;
}

Array.prototype.last = function() {
  return this[this.length - 1];
}

Array.prototype.max = function() {
  if(this.length === 0){ return null; }
  return this.reduce( (a, b) => a > b ? a : b )
  return this.reduce(function (a, b) {return Math.max(a, b);})
}

Array.prototype.min = function() {
  if(this.length === 0){ return null; }
  return this.reduce( (a, b) => a < b ? a : b )
  return this.reduce(function (a, b) {return Math.min(a, b);})
}

Array.prototype.prod = function() {
  return this.reduce((res, num) => res * num);
  return this.reduce((res, num) => { return res * num; }, 1);
}

Array.prototype.sample = function() {
  return this[Math.floor(Math.random() * this.length)];
}

Array.prototype.sum = function(init) {
  if(init){
    return this.reduce((total, num) => total + num, init);
  }else{
    if (this.length === 0){ return 0; }
    return this.reduce((total, num) => total + num);
  }
}

// https://www.softel.co.jp/blogs/tech/archives/2328
Array.prototype.shuffle = function() {
  var i = this.length;
  while(i){
      var j = Math.floor(Math.random()*i);
      var t = this[--i];
      this[i] = this[j];
      this[j] = t;
  }
  return this;
}

Array.prototype.sortNumbers = function() {
  return this.sort((x, y) => x - y);
}

Array.prototype.tally = function() {
  let res = {};
  for(let key of this){
    res.hasOwnProperty(key) ? (res[key] += 1) : (res[key] = 1)
  }
  return res;
}

Array.prototype.uniq = function() {
  return Array.from(new Set(this));
}

module.exports = {
  isArray,
  isEmptyArray,
  prod,
  sum,
  uniq,
}

// console.log([1, 2, 3, 4].equals([1, 2, 3]))
// console.log([1, 2, 3].equals([1, 2, 3, 4]))
// console.log([1, 2, 3].equals([1, 2, 3]))
// console.log([].equals([]))

// console.log(3 == 3n)
// console.log(3 === 3n)
// console.log([1, 2, 3].equals([1n, 2n, 3n]))

// Dont't forget `return` to use sum function;s

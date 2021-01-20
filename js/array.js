"use strict";

// function duplicateArray(ary){ return ary.slice(); }
function duplicateArray(ary){ return ary.concat(); }
function isArray(obj){ return Array.isArray(obj); }
function isEmptyArray(ary) { return ary.length === 0; }
function prod(numbers) { return numbers.reduce((res, num) => { return res * num; }, 1); }
function sum(numbers) { return numbers.reduce((total, num) => { return total + num; }, 0); }
function uniq(numbers) { return Array.from(new Set(numbers)); }

module.exports = {
  isArray,
  isEmptyArray,
  prod,
  sum,
  uniq,
}

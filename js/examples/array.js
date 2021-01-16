const { sum, prod, isArray, isEmptyArray } = require('../array');

a = [1, 2, 3, 4, 5];
console.log(sum(a));
console.log(prod(a));

console.log(a);
console.log(a.reverse());
console.log(a);

console.log(isEmptyArray([]));
console.log(isEmptyArray(a));

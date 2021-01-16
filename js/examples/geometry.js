const { Point } = require('../geometry');

const point = new Point(3, 4);
console.log(point.x); // => 3
console.log(point.y); // => 4

z = new Point();
a = new Point(3, 4);
a2 = new Point(6, 8);
console.log((z.add(a)))
console.log((a.times(2)))
console.log(a.abs)
console.log(a.isParallel(a2))

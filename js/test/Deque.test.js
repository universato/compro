const Deque = require('../Deque.js');

test('push', () => {
  const d = new Deque([1, 2, 3]);
  expect(d.to_a()).toMatchObject([1, 2, 3]);
  d.push(4)
  d.push(5)
  expect(d.to_a()).toMatchObject([1, 2, 3, 4, 5]);
  d.unshift(99)
  d.unshift(98)
  expect(d.to_a()).toMatchObject([98, 99, 1, 2, 3, 4, 5]);
});

test('pop', () => {
  const d = new Deque([10, 20, 30])
  d.shift();
  expect(d.to_a()).toMatchObject([20, 30]);
  d.pop();
  expect(d.to_a()).toMatchObject([20]);
});

test('reverse', () => {
  const d = new Deque([10, 20, 30]);
  d.reverse();
  expect(d.to_a()).toMatchObject([30, 20, 10]);
  d.reverse();
  expect(d.to_a()).toMatchObject([10, 20, 30]);
});

test('swap', () => {
  const d = new Deque([10, 20, 30]);
  d.swap(0, 1)
  expect(d.to_a()).toMatchObject([20, 10, 30]);
  d.swap(2, 0)
  expect(d.to_a()).toMatchObject([30, 10, 20]);
});

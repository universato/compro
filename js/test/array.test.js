const { sum, prod, isArray, isEmptyArray } = require('../array');

test('delete', () => {
  let a = [0, 10, 20, 30, 40]
  expect(a.delete_at(2)).toMatchObject([20]);
  expect(a).toMatchObject([0, 10, 30, 40]);
});

test('max', () => {
  expect([1, 10, 20, 5].max()).toBe(20);
  expect([-1, -10, -20, -5].max()).toBe(-1);
});

test('min', () => {
  expect([1, 10, 20, 5].min()).toBe(1);
  expect([1, 10, 20, 5, -20].min()).toBe(-20);
});

test('sortNumbers', () => {
  expect([1, 10, 20, 5].sortNumbers()).toMatchObject([1, 5, 10, 20]);
});

test('sum', () => {
  expect(sum([])).toBe(0);
  expect(sum([3])).toBe(3);
  expect(sum([3, -4])).toBe(-1);
  expect(sum([1, 2, 3, 4, 5])).toBe(15);
});

test('tally', () => {
  expect([].tally()).toMatchObject({});
  expect([5, 4, 5, 4, 4].tally()).toMatchObject({'4': 3, '5': 2});
  expect(['ab', 'a', 'a', 'ab'].tally()).toMatchObject({'a': 2, 'ab': 2});
  expect([1, '1', 1.0, 1n].tally()).toMatchObject({'1': 4});
});


test('prod', () => {
  expect(prod([])).toBe(1);
  expect(prod([3])).toBe(3);
  expect(prod([3, -4])).toBe(-12);
  expect(prod([1, 2, 3, 4, 5])).toBe(120);
});

test('isArray', () => {
  expect(isArray([])).toBe(true);
  expect(isArray([3])).toBe(true);
  expect(isArray([1, 2, 3, 4, 5])).toBe(true);
  expect(isArray("abc")).toBe(false);
  expect(isArray(1)).toBe(false);
  expect(isArray(undefined)).toBe(false);
  expect(isArray(true)).toBe(false);
});

test('isEmpty', () => {
  expect(isEmptyArray([])).toBe(true);
  expect(isEmptyArray([3])).toBe(false);
  expect(isEmptyArray([1, 2, 3, 4, 5])).toBe(false);

  expect([].isEmpty()).toBe(true);
  expect([3].isEmpty()).toBe(false);
  expect([1, 2, 3, 4, 5].isEmpty()).toBe(false);
});

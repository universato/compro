const floor_sum = require('./floor_sum');
test('floor_sum(4, 10, 6, 3) to equal 3', () => {
  expect(floor_sum(4n, 10n, 6n, 3n)).toBe(3n);
  expect(floor_sum(6n, 5n, 4n, 3n)).toBe(13n);
  expect(floor_sum(1n, 1n, 0n, 0n)).toBe(0n);
  expect(floor_sum(31415n, 92653n, 58979n, 32384n)).toBe(314095480n);
  expect(floor_sum(1000000000n, 1000000000n, 999999999n, 999999999n)).toBe(499999999500000000n);
});

// npm test

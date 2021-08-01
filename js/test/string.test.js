const { chr, ord, chars, capitalize, isEmptyString, reverseString } = require('../String');

test('chr', () => {
  expect(chr(65)).toBe("A");
  expect(chr(97)).toBe("a");

  expect((65).chr()).toBe("A");
  expect((97).chr()).toBe("a");
});

test('ord', () => {
  expect(ord('A')).toBe(65);
  expect(ord('a')).toBe(97);

  expect('A'.ord()).toBe(65);
  expect('a'.ord()).toBe(97);
});

test('chars', () => {
  expect(chars("")).toMatchObject([]);
  expect(chars("Hello")).toMatchObject(['H', 'e', 'l', 'l', 'o']);

  expect("".chars()).toMatchObject([]);
  expect("Hello".chars()).toMatchObject(['H', 'e', 'l', 'l', 'o']);
});

test('capitalize', () => {
  expect(capitalize("")).toBe("");
  expect(capitalize("a")).toBe("A");
  expect(capitalize("Z")).toBe("Z");
  expect(capitalize("hello")).toBe("Hello");
  expect(capitalize("HeLLO")).toBe("Hello");
  expect(capitalize("heLLo")).toBe("Hello");
});

test('reverseString', () => {
  expect(reverseString("")).toBe("");
  expect(reverseString("a")).toBe("a");
  expect(reverseString("ABC")).toBe("CBA");

  expect("".reverse()).toBe("");
  expect("a".reverse()).toBe("a");
  expect("ABC".reverse()).toBe("CBA");
});

test('isEmptyString', () => {
  expect(isEmptyString("")).toBe(true);
  expect(isEmptyString("a")).toBe(false);
  expect(isEmptyString("ABC")).toBe(false);

  expect("".isEmpty()).toBe(true);
  expect("a".isEmpty()).toBe(false);
  expect("ABC".isEmpty()).toBe(false);
});

const { keys, values, hasKey } = require('../Object');

test('keys', () => {
  // expect(keys({}).toString()).toBe([].toString());
  // expect(keys({name: "Tanaka"}).toString()).toBe(["name"].toString());

  expect({}.keys()).toMatchObject([]);
  expect({name: "Tanaka"}.keys()).toMatchObject(["name"])
});

test('values', () => {
  // expect(values({}).toString()).toBe([].toString());
  // expect(values({name: "Tanaka"}).toString()).toBe(["Tanaka"].toString());

  expect({}.values()).toMatchObject([]);
  expect({name: "Tanaka"}.values()).toMatchObject(["Tanaka"])
});

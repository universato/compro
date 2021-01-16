const { keys, values, hasKey, arrayFromObject } = require('../object');

obj = { name: "Smith", age: 20 };
console.log(keys(obj));
console.log(values(obj));
console.log(arrayFromObject(obj));
console.log(hasKey(obj, "name"));
console.log("toString" in obj);

const { chr, ord, chars, capitalize, isEmptyString, reverseString } = require('../string');

console.log(chars("hello"));

console.log(chr(97));
console.log(chr(65));

console.log(ord('abc'));

s = "aBC";
console.log(isEmptyString(s));
console.log(reverseString(s));
console.log(s);
console.log(s.toUpperCase());
console.log(s.toLowerCase());
console.log(s);
console.log(capitalize(s));

s = '';
console.log(isEmptyString(s));
console.log(capitalize(s));


// 文字列はimmutableで破壊的変更は出来ないっぽい。
// s.lengthはメソッドじゃなくて、プロパティ(?)なんだね。

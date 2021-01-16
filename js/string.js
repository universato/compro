"use strict";

function capitalize(s){ return s.length === 0 ? '' : s[0].toUpperCase() + s.toLowerCase().slice(1);  }
function chars(str){ return str.split(''); }
// function chars(str){ return Array.from(str); }
function chr(n){ return String.fromCharCode(n); }
function ord(c){ return c.charCodeAt();  }
function isEmptyString(s){ return s.length === 0; }
function reverseString(s){ return s.split('').reverse().join(''); }

module.exports = {
  capitalize,
  chars,
  chr,
  ord,
  isEmptyString,
  reverseString,
}

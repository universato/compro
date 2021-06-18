"use strict";

function capitalize(s){ return s.length === 0 ? '' : s[0].toUpperCase() + s.toLowerCase().slice(1);  }
function chars(str){ return str.split(''); }
// function chars(str){ return Array.from(str); }
function chr(n){ return String.fromCharCode(n); }
function ord(c){ return c.charCodeAt();  }
function isEmptyString(s){ return s.length === 0; }
function reverseString(s){ return s.split('').reverse().join(''); }


String.prototype.capitalize = function() {
  return this.length === 0 ? '' : this[0].toUpperCase() + this.toLowerCase().slice(1);
}

String.prototype.chars = function() {
  return this.split('');
}

Number.prototype.chr = function() {
  return String.fromCharCode(this);
}

String.prototype.ord = function() {
  return this.charCodeAt();
}

String.prototype.isEmpty = function() {
  return this.length === 0;
}

String.prototype.reverse = function() {
  return this.split('').reverse().join('');
}

String.prototype.downcase = function(){
  return this.toLowerCase();
}

String.prototype.upcase = function(){
  return this.toUpperCase();
}

module.exports = {
  capitalize,
  chars,
  chr,
  ord,
  isEmptyString,
  reverseString,
}

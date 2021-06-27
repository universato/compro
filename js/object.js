"use strict";

function keys(obj){ return Object.keys(obj); }
function values(obj){ return Object.values(obj); }
function arrayFromObject(obj){ return Object.entries(obj); }

const keysOf = keys;
const valuesOf = values;

Object.prototype.hasKey = function(key) {
  return this.hasOwnProperty(key);
}

Object.prototype.isEmpty = function() {
  return !Object.keys(this).length;
}

Object.prototype.keys = function() {
  return Object.keys(this);
}

Object.prototype.values = function() {
  return Object.values(this);
}

module.exports = {
  keys,
  keysOf,
  values,
  valuesOf,
  arrayFromObject
}

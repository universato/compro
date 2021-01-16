"use strict";

function keys(obj){ return Object.keys(obj); }
function values(obj){ return Object.values(obj); }
function arrayFromObject(obj){ return Object.entries(obj); }
function isEmptyObject(obj){ return !Object.keys(obj).length; }
function hasKey(obj, key){ return obj.hasOwnProperty(key); }
// function delete(obj){ return; }

const keysOf = keys;
const valuesOf = values;

module.exports = {
  keys,
  values,
  hasKey,
  arrayFromObject
}

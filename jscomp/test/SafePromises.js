'use strict';

var Js_promise2 = require("../../lib/js/js_promise2.js");

async function nestedPromise(xxx) {
  var xx = await xxx;
  Js_promise2.then(xx, (function (x) {
          return Promise.resolve((console.log("Promise2.then", x), undefined));
        }));
  Js_promise2.$$catch(xx, (function (x) {
          console.log("Promise2.catch_", x);
          return Promise.resolve(0);
        }));
  var arg1 = function (x) {
    return Promise.resolve((console.log("Promise.then_", x), undefined));
  };
  xx.then(arg1);
}

async function create(x) {
  console.log("create", x);
  return x;
}

var xx = create(10);

var xxx = create(xx);

nestedPromise(xxx);

exports.nestedPromise = nestedPromise;
exports.create = create;
exports.xx = xx;
exports.xxx = xxx;
/* xx Not a pure module */

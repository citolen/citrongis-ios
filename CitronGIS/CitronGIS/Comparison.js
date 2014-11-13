/*
 * Author citole_n
 * Created 17/05/2014
 */

var C = C || {};

C.Utils = C.Utils || {};

C.Utils.Comparison = {};

C.Utils.Comparison.kEpsilon = 1E-5;

C.Utils.Comparison.Equals = function (a, b) {
    "use strict";
    return (Math.abs(a - b) < C.Utils.Comparison.kEpsilon);
};

/*
**
**  Context.js
**
**  Author citole_n
**
**  27/10/2014
*/

var C = C || {};

C.Utils = C.Utils || {};
C.Utils.Context = C.Utils.Context || {};

C.Utils.Context.copy = function (oldContext, path) {
    var newContext = C.Utils.Object.copy(oldContext);
    newContext.currentPath = path;
    return (newContext);
};

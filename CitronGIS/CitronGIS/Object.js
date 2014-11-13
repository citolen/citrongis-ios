/*
**
**  Author citole_n
**
**  27/10/2014
**
*/

var C = C || {};
C.Utils = C.Utils || {};
C.Utils.Object = C.Utils.Object || {};

C.Utils.Object.copy = function (obj) {
    var copy = {};
    var i;

    for (i in obj) {
        copy[i] = obj[i];
    }
    return (copy);
};

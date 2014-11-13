/*
**  Bridge.js
**
**  Author citole_n
**  16/08/2014
*/

var C = C || {};
C.Extension = C.Extension || {};
C.Extension.UI = C.Extension.UI || {};

C.Extension.UI.Bridge = function () {

    this.functions = [];

    this.idGen = 0;
};

C.Extension.UI.Bridge.prototype.register = function (fct) {
    var id = this.idGen++;
    this.functions[id] = fct;
    return (id);
};

C.Extension.UI.Bridge.prototype.bridge = function (id) {
    if (!this.functions[id]) return;
    this.functions[id]();
};

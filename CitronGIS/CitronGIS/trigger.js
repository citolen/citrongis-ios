/*
**  function.js
**
**  Author citole_n
**  15/08/2014
*/

var C = C || {};
C.Extension = C.Extension || {};
C.Extension.UI = C.Extension.UI || {};

C.Extension.UI.trigger = function (fct) {
    if (typeof fct == 'function') {
        var args = Array.prototype.slice.call(arguments, 1);
        if (args.length == 0)
            args = undefined;
        var _ = fct.bind(this.module.global, args);
        var id = this.module.ui.register(_);
        return ('C.Extension.Manager.bridge(\'' + this.package.name + '\', ' + id + ');');
    }
};

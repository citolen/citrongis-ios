/*
**  UI.js
**
**  Author citole_n
**  16/08/2014
*/

var C = C || {};
C.Extension = C.Extension || {};
C.Extension.UI = C.Extension.UI || {};

C.Extension.UI.UI = C.Utils.Inherit(C.Utils.Inherit(function (_context) {
    "use strict";

    this._context = _context;

    this.current = undefined;
}, EventEmitter, 'C.Extension.UI.UI'), C.Extension.UI.Bridge, 'C.Extension.UI.UI');

//////////////////////////
// Display an interface //
//////////////////////////
C.Extension.UI.UI.prototype.display = function (path) {
    "use strict";
    var page = C.Extension.Require.call(this._context, path);
    if (!page) return;

    var context = C.Utils.Context.copy(this._context);
    context.currentPath = path;
    var citrongisCtx = {
        require: C.Extension.Require.bind(context),
        include: C.Extension.UI.include.bind(context)
    };
    var result = new EJS({text: page}).render(this._context.module.global, {}, citrongisCtx);

    var handler = document.createElement('DIV');
    handler.innerHTML = result;
    this.current = handler;
    this.emit('display', handler);
    this._context.module.global.UI.emit('loaded', handler);
};

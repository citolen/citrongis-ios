/*
**  Module.js
**
**  Author citole_n
**  16/08/2014
*/

var C = C || {};
C.Extension = C.Extension || {};

// Module Constructor
// @strings : localization string (strings.json)
C.Extension.Module = function (_context, strings) {

    this._context = _context;

    // Part visible by a require
    this.exports = {};

    this.strings = strings;

    // Bind point
    this.global = {};

    this.ui = new C.Extension.UI.UI(_context);
};

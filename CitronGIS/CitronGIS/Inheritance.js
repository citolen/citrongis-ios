/*
**  Inheritance.js
**
**  Author citole_n
**  16/08/2014
*/

var C = C || {};
C.Utils = C.Utils || {};

/*
** Extends @dest with the property of all the arguments object after @dest
*/
C.Utils.Extends = function (dest) {
    "use strict";
    var i, j, len, src;

    for (j = 1, len = arguments.length; j < len; ++j) {
        src = arguments[j];
        for (i in src) {
            dest[i] = src[i];
        }
    }
    return dest;
};

/*
**  Create a class with @constructor as constructor,
**  @classToInherit as the base class and can optionaly be
**  set to a namespace/object with @name
*/
C.Utils.Inherit = function (constructor, classToInherit, name) {
    var _;
    if (name === undefined) {
        _ = function () {
            classToInherit.apply(this, arguments);
            constructor.apply(this, arguments);
        };
    } else {
        _ = eval(name + ' = function () {\
                                classToInherit.apply(this, arguments);\
                                constructor.apply(this, arguments);\
                            };');
    }
    C.Utils.Extends(_.prototype, constructor.prototype);
    C.Utils.Extends(_.prototype, new classToInherit());
    return (_);
};

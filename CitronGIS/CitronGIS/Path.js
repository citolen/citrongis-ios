/*
**
**  Path.js
**
**  Author citole_n, david.kaye
**
**  27/10/2014
*/

var C = C || {};

C.Utils = C.Utils || {};
C.Utils.Path = C.Utils.Path || {};

C.Utils.Path.normalize = function (path) {

    'use strict';

    var BLANK = '';
    var SLASH = '/';
    var DOT = '.';
    var DOTS = DOT.concat(DOT);
    var SCHEME = '://';


    if (!path || path === SLASH) {
        return SLASH;
    }

        /*
           * for IE 6 & 7 - use path.charAt(i), not path[i]
           */
    var prependSlash = (path.charAt(0) == SLASH || path.charAt(0) == DOT);
    var target = [];
    var src;
    var scheme;
    var parts;
    var token;

    if (path.indexOf(SCHEME) > 0) {

        parts = path.split(SCHEME);
        scheme = parts[0];
        src = parts[1].split(SLASH);
    } else {

        src = path.split(SLASH);
    }

    for (var i = 0; i < src.length; ++i) {

        token = src[i];

        if (token === DOTS) {
            target.pop();
        } else if (token !== BLANK && token !== DOT) {
            target.push(token);
        }
    }

    var result = target.join(SLASH).replace(/[\/]{2,}/g, SLASH);

    return (scheme ? scheme + SCHEME : '') + (prependSlash ? SLASH : BLANK) + result;
};

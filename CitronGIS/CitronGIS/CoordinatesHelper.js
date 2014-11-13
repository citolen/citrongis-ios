/*
 * Author citole_n
 * Created 06/05/2014
 */

var C = C || {};
var proj4 = proj4 || {};

C.Helpers = C.Helpers || {};

C.Helpers.CoordinatesHelper = {};

///////////////////////////////////////////////////////////////////////////////////
// TransformTo                                                                   //
// Transform @point to the projection @to and return a new point with the result //
///////////////////////////////////////////////////////////////////////////////////
/*jslint nomen: true*/
C.Helpers.CoordinatesHelper.TransformTo = function (point, to) {
    "use strict";
    var tmp = proj4(point.CRS, to, [point.X, point.Y]);
    return (new C.Geometry.Point(tmp[0], tmp[1], point.Z, C.Helpers.CoordinatesHelper._checkProj(to)));
};
/*jslint nomen: false*/

///////////////////////////////
// _checkProj                //
// Return a valid projection //
///////////////////////////////
/*jslint nomen: true*/
C.Helpers.CoordinatesHelper._checkProj = function (item) {
    "use strict";
    if (item === undefined) {
        return (item);
    } else if (item instanceof proj4.Proj) {
        return (item);
    } else if (item.oProj) {
        return (item.oProj);
    }
    return (new proj4.Proj(item));
};
/*jslint nomen: false*/

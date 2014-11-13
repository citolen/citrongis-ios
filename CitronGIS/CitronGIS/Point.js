/*
 * Author citole_n
 * Created 06/05/2014
 *
 *
 */

var C = C || {};

C.Geometry = C.Geometry || {};

/*
 * Constructor
 */
/*jslint nomen: true*/
C.Geometry.Point = function (x, y, z, crs) {
    "use strict";

    /* X */
    this.X = x || 0.0;

    /* Y */
    this.Y = y || 0.0;

    /* Z */
    this.Z = z || 0.0;

    /* Coordinate Reference System */
    this.CRS = C.Helpers.CoordinatesHelper._checkProj(crs);
};
/*jslint nomen: false*/

/*
 * Pretty print
 */
C.Geometry.Point.prototype.toString = function () {
    "use strict";
    return ("{ x: " + this.X + ", y: " + this.Y + ", z: " + this.Z + ", CRS: " + (this.CRS.name || this.CRS.title || this.CRS) + "}");
};

/*
 * Transform this point to the projection to
 */
C.Geometry.Point.prototype.TransformTo = function (to) {
    "use strict";
    var tmp = C.Helpers.CoordinatesHelper.TransformTo(this, to);
    this.X = tmp.X;
    this.Y = tmp.Y;
    this.Z = tmp.Z;
    this.CRS = tmp.CRS;
    return (this);
};

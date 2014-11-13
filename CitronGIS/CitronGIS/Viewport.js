/*
 * Author citolen
 * Created 26/05/2014
 */

var C = C || {};

C.System = C.System || {};

/////////////////
// Constructor //
/////////////////
C.System.Viewport = function (width, height, resolution, extent) {
    "use strict";
    this.Width = (width instanceof Number) ? (width) : 0; // px

    this.Height = (height instanceof Number) ? (height) : 0; // px

    this.Resolution = (resolution instanceof Number) ? (resolution) : 0; // resolution m/px

    this.Extent = (extent instanceof C.Geometry.BoundingBox) ? (extent) : new C.Geometry.BoundingBox(); // Extent type boundingbox
};

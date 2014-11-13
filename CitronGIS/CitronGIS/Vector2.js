/*
 *  Author citole_n
 *  Create 17/05/2014
 */

var C = C || {};
C.Geometry = C.Geometry || {};

/////////////////
// Constructor //
/////////////////
C.Geometry.Vector2 = function (x, y) {
    "use strict";

    this.X = x || 0.0;

    this.Y = y || 0.0;
};

////////////////////////////////////////////////////
// Distance                                       //
// Return distance between a Vector2 and this one //
////////////////////////////////////////////////////
C.Geometry.Vector2.prototype.Distance = function (vb) {
    "use strict";
    return (Math.sqrt(Math.pow(this.X - vb.X, 2) +
                      Math.pow(this.Y - vb.Y, 2)));
};

//////////////////////////////////////////////////
// Equals                                       //
// Test equality between a Vector2 and this one //
//////////////////////////////////////////////////
C.Geometry.Vector2.prototype.Equals = function (vb) {
    "use strict";
    if (C.Utils.Comparison.Equals(this.X, vb.X) && C.Utils.Comparison.Equals(this.Y, vb.Y)) {
        return (true);
    }
    return (false);
};

///////////////////////////////////////////////////////////
// DotProduct                                            //
// Return the dot product between a Vector2 and this one //
///////////////////////////////////////////////////////////
C.Geometry.Vector2.prototype.DotProduct = function (vb) {
    "use strict";
    return (this.X * vb.X + this.Y * vb.Y);
};

//////////////////
// toString     //
// Pretty print //
//////////////////
C.Geometry.Vector2.prototype.toString = function () {
    "use strict";
    return ("{ x:" + this.X + ", y:" + this.Y + " }");
};


/////////////////////////////////////////
// Static Distance                     //
// Return distance between two Vector2 //
/////////////////////////////////////////
C.Geometry.Vector2.Distance = function (va, vb) {
    "use strict";
    return (va.Distance(vb));
};


///////////////////////////////////////
// Static Equals                     //
// Test equality between two Vector2 //
///////////////////////////////////////
C.Geometry.Vector2.Equals = function (va, vb) {
    "use strict";
    return (va.Equals(vb));
};

///////////////////////////////////////////////////////////
// Static DotProduct                                     //
// Return the dot product between a Vector2 and this one //
///////////////////////////////////////////////////////////
C.Geometry.Vector2.DotProduct = function (va, vb) {
    "use strict";
    return (va.DotProduct(vb));
};

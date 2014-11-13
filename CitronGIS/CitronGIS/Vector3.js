/*
 * Author citole_n
 * Created 17/05/2014
 */

var C = C || {};

C.Geometry = C.Geometry || {};

/////////////////
// Constructor //
/////////////////
C.Geometry.Vector3 = function (x, y, z) {
    "use strict";

    this.X = x || 0.0;

    this.Y = y || 0.0;

    this.Z = z || 0.0;
};

////////////////////////////////////////////////////
// Distance                                       //
// Return distance between a Vector3 and this one //
////////////////////////////////////////////////////
C.Geometry.Vector3.prototype.Distance = function (vb) {
    "use strict";
    return (Math.sqrt(Math.pow(this.X - vb.X, 2) +
                      Math.pow(this.Y - vb.Y, 2) +
                      Math.pow(this.Z - vb.Z, 2)));
};

//////////////////////////////////////////////////
// Equals                                       //
// Test equality between a Vector3 and this one //
//////////////////////////////////////////////////
C.Geometry.Vector3.prototype.Equals = function (vb) {
    "use strict";
    if (C.Utils.Comparison.Equals(this.X, vb.X) &&
            C.Utils.Comparison.Equals(this.Y, vb.Y) &&
            C.Utils.Comparison.Equals(this.Z, vb.Z)) {
        return (true);
    }
    return (false);
};

///////////////////////////////////////////////////////////
// DotProduct                                            //
// Return the dot product between a Vector3 and this one //
///////////////////////////////////////////////////////////
C.Geometry.Vector3.prototype.DotProduct = function (vb) {
    "use strict";
    return (this.X * vb.X + this.Y * vb.Y + this.Z * vb.Z);
};

//////////////////////////////////////////////////
// Cross                                        //
// Cross product between a Vector3 and this one //
//////////////////////////////////////////////////
C.Geometry.Vector3.prototype.Cross = function (vb) {
    "use strict";
    return (new C.Geometry.Vector3(
        (this.Y * vb.Z) - (this.Z * vb.Y),
        (this.Z * vb.X) - (this.X * vb.Z),
        (this.X * vb.Y) - (this.Y * vb.X)
    ));
};

//////////////////
// toString     //
// Pretty print //
//////////////////
C.Geometry.Vector3.prototype.toString = function () {
    "use strict";
    return ("{ x:" + this.X + ", y:" + this.Y + ", z:" + this.Z + "}");
};

/////////////////////////////////////////
// Static Distance                     //
// Return distance between two Vector3 //
/////////////////////////////////////////
C.Geometry.Vector3.Distance = function (va, vb) {
    "use strict";
    return (va.Distance(vb));
};

///////////////////////////////////////
// Static Equals                     //
// Test equality between two Vector3 //
///////////////////////////////////////
C.Geometry.Vector3.Equals = function (va, vb) {
    "use strict";
    return (va.Equals(vb));
};

///////////////////////////////////////////////////////////
// Static DotProduct                                     //
// Return the dot product between a Vector3 and this one //
///////////////////////////////////////////////////////////
C.Geometry.Vector3.DotProduct = function (va, vb) {
    "use strict";
    return (va.DotProduct(vb));
};

//////////////////////////////////////////////////
// Static Cross                                 //
// Cross product between a Vector3 and this one //
//////////////////////////////////////////////////
C.Geometry.Vector3.prototype.Cross = function (va, vb) {
    "use strict";
    return (new C.Geometry.Vector3(
        (va.Y * vb.Z) - (va.Z * vb.Y),
        (va.Z * vb.X) - (va.X * vb.Z),
        (va.X * vb.Y) - (va.Y * vb.X)
    ));
};

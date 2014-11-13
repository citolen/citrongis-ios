/*
 * Author citole_n
 * Created 17/05/2014
 */

var C = C || {};

C.Geometry = C.Geometry || {};

/////////////////
// Constructor //
/////////////////
C.Geometry.BoundingBox = function (bottomLeft, topLeft, topRight, bottomRight) {
    "use strict";

    this.BottomLeft = bottomLeft || new C.Geometry.Vector2();

    this.TopLeft = topLeft || new C.Geometry.Vector2();

    this.TopRight = topRight || new C.Geometry.Vector2();

    this.BottomRight = bottomRight || new C.Geometry.Vector2();
};

//////////////
// toString //
//////////////
C.Geometry.BoundingBox.prototype.toString = function () {
    "use strict";
    return ("{ BottomLeft:" + this.BottomLeft + ", TopLeft:" + this.TopLeft + ", TopRight:" + this.TopRight + ", BottomRight:" + this.BottomRight + "}");
};

////////////
// Equals //
////////////
C.Geometry.BoundingBox.prototype.Equals = function (b) {
    "use strict";
    if (this.BottomLeft.Equals(b.BottomLeft) &&
            this.BottomRight.Equals(b.BottomRight) &&
            this.TopLeft.Equals(b.TopLeft) &&
            this.TopRight.Equals(b.TopRight)) {
        return (true);
    }
    return (false);
};

//////////////////////////////////////////
// Center                               //
// Return the center of the BoundingBox //
//////////////////////////////////////////
C.Geometry.BoundingBox.prototype.Center = function () {
    "use strict";
    var x = (this.BottomLeft.X + this.BottomRight.X + this.TopLeft.X + this.TopRight.X) / 4.0,
        y = (this.BottomLeft.Y + this.BottomRight.Y + this.TopLeft.Y + this.TopRight.Y) / 4.0;
    return (new C.Geometry.Vector2(x, y));
};

//////////////////////////////////////////////////////////////
// Intersect                                                //
// Test if a point or a BoundingBox intersect with this one //
//////////////////////////////////////////////////////////////
C.Geometry.BoundingBox.prototype.Intersect = function (o) {
    "use strict";
    if (o instanceof C.Geometry.BoundingBox) {
        if (C.Utils.Intersection.IsPointInsideRectangle(this.TopLeft, this.TopRight, this.BottomRight, this.BottomLeft, o.TopLeft) ||
                C.Utils.Intersection.IsPointInsideRectangle(this.TopLeft, this.TopRight, this.BottomRight, this.BottomLeft, o.TopRight) ||
                C.Utils.Intersection.IsPointInsideRectangle(this.TopLeft, this.TopRight, this.BottomRight, this.BottomLeft, o.BottomRight) ||
                C.Utils.Intersection.IsPointInsideRectangle(this.TopLeft, this.TopRight, this.BottomRight, this.BottomLeft, o.BottomLeft)) {
            return (true);
        }
        return (false);
    } else {
        return (C.Utils.Intersection.IsPointInsideRectangle(this.TopLeft, this.TopRight, this.BottomRight, this.BottomLeft, o));
    }
};

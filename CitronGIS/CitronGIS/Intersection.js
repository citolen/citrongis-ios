/*
 * Author citole_n
 * Created 17/05/2014
 */

var C = C || {};

C.Utils = C.Utils || {};

C.Utils.Intersection = {};

C.Utils.Intersection.Test = function (a, b, p) {
    "use strict";
    if ((a.Y > p.Y) !== (b.Y > p.Y) && (p.X < (b.X - a.X) * (p.Y - a.Y) / (b.Y - a.Y) + a.X)) {
        return (true);
    }
    return (false);
};

C.Utils.Intersection.IsPointInsideRectangle = function (a, b, c, d, p) {
    "use strict";
    if (C.Utils.Intersection.Test(a, b, p) ||
            C.Utils.Intersection.Test(b, c, p) ||
            C.Utils.Intersection.Test(c, d, p) ||
            C.Utils.Intersection.Test(d, a, p)) {
        return (true);
    }
    return (false);
};

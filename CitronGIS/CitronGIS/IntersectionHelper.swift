//
//  IntersectionHelper.swift
//  CitronGIS
//
//  Created by Charly DELAROCHE on 5/28/15.
//  Copyright (c) 2015 Charly DELAROCHE. All rights reserved.
//

import Foundation

class IntersectionHelper {
    class func polygonContainsPoint(polygon:[Vector2], p:Vector2) -> Bool
    {
        var inside = false
        
        for var i = 0, j = polygon.count - 1; i < polygon.count; j = i++ {
            var xi = polygon[i].x
            var yi = polygon[i].y
            var xj = polygon[j].x
            var yj = polygon[j].y
            
            var intersect = ((yi > p.y) != (yj > p.y)) && (p.x < (xj - xi) * (p.y - yi) / (yj - yi) + xi)
            if (intersect) {
                inside = !inside
            }
        }
        return inside
    }
    class func lineIntersection(p1:Vector2, p2:Vector2, p3:Vector2, p4:Vector2) -> Bool
    {
        let a = [p2.x - p1.x, p2.y - p1.y]
        let b = [p3.x - p4.x, p3.y - p4.y]
        let c = [p1.x - p3.x, p1.y - p3.y]
        let alphaNumerator = b[1] * c[0] - b[0] * c[1]
        let alphaDenominator = a[1] * b[0] - a[0] * b[1]
        let betaNumerator = a[0] * c[1] - a[1] * c[0]
        let betaDenominator = alphaDenominator
        if (alphaDenominator == 0 || betaDenominator == 0) {
            return (false)
        }
        if (alphaDenominator > 0)
        {
            if (alphaNumerator < 0 || alphaNumerator > alphaDenominator) {
                return (false)
            }
        }
        else if (alphaNumerator > 0 || alphaNumerator < alphaDenominator)
        {
            return (false)
        }
        if (betaDenominator > 0)
        {
            if (betaNumerator < 0 || betaNumerator > betaDenominator) {
                return (false)
            }
        }
        else if (betaNumerator > 0 || betaNumerator < betaDenominator)
        {
            return (false)
        }
        return true
    }
    
    class func polygonContainsPolygon(p1:[Vector2], p2:[Vector2]) -> Bool
    {
        if (IntersectionHelper.polygonContainsPoint(p2, p: p2[0]))
        {
            return true
        }
        var i = 0
        var n = p1.count - 1
        var m = p2.count - 1
        for (var k = 0; k < p1.count; ++k)
        {
            var a = p1[k]
            var b = (i == n) ? (p1[0]) : (p1[i + 1])
            var j = 0
            for (var l = 0; l < p2.count; ++l)
            {
                var c = p2[l]
                var d = (j == m) ? (p2[0]) : (p2[j + 1])
                if (IntersectionHelper.lineIntersection(a, p2: b, p3: c, p4: d))
                {
                    return true
                }
                ++j
            }
            ++i
        }
        return (IntersectionHelper.polygonContainsPoint(p1, p: p2[0]))
    }
}
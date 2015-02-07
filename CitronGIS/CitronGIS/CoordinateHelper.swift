//
//  CoordinateHelper.swift
//  CitronGIS
//
//  Created by Charly DELAROCHE on 2/6/15.
//  Copyright (c) 2015 Charly DELAROCHE. All rights reserved.
//

import Foundation

class CoordinateHelper {
    class func transformTo(point:GeometryPoint, proj:Projection) -> GeometryPoint
    {
        var re:GeometryPoint = GeometryPoint(fromPosx: point.x, andY: point.y, andZ: point.z, andProj: proj)
        
        
        var tmp = pj_transform(point.proj.projection, proj.projection, 1, 0, &re.x, &re.y, &re.z)

        return re        
    }
}
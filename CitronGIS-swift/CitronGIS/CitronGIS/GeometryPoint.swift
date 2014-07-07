//
//  GeometryPoint.swift
//  CitronGIS
//
//  Created by Charly DELAROCHE on 30/06/14.
//  Copyright (c) 2014 Charly DELAROCHE. All rights reserved.
//

import Foundation

class GeometryPoint
{
    var x: Double
    {
    get {
        return self.x
    }
    set(newX) {
        self.x = newX
    }
    }
    var y: Double
    {
    get {
        return self.y
    }
    set(newY) {
        self.y = newY
    }
    }
    var z: Double
    {
    get {
        return self.z
    }
    set(newZ) {
        self.z = newZ
    }
    }
    var proj: Projection
    
    init(fromPosx x:Double, andY y:Double, andZ z:Double, andProj proj:Projection)
    {
        self.proj = proj
        self.x = x
        self.y = y
        self.z = z
    }
    func transformToProj(fromProj proj:Projection)
    {
        pj_transform(self.proj.projection, proj.projection, 1, 0, &x, &y, &z)
        self.proj = proj
    }
    var description: String {
        return "\(x)-\(y)-\(z)-\(proj)"
    }
}
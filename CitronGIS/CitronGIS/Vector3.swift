//
//  Vector3.swift
//  CitronGIS
//
//  Created by Charly DELAROCHE on 5/11/15.
//  Copyright (c) 2015 Charly DELAROCHE. All rights reserved.
//

import Foundation

class Vector3
{
    var x: Double
    var y: Double
    var z: Double
    
    init()
    {
        x = 0
        y = 0
        z = 0
    }
    init(fromPosx x:Double, andY y:Double, andZ z:Double)
    {
        self.x = x
        self.y = y
        self.z = z
    }
    func dotProductwithVector(anotherPoint p:Vector3) -> Double
    {
        return p.x * x + p.y * y + p.z * z
    }
    var description: String {
        return "\(x)-\(y)"
    }
}

func ==(lhs: Vector3, rhs: Vector3) -> Bool
{
    return lhs.x == rhs.x && lhs.y == rhs.y && lhs.z == rhs.z
}
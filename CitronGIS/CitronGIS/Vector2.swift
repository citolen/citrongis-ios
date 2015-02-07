//
//  Vector2.swift
//  CitronGIS
//
//  Created by Charly DELAROCHE on 30/06/14.
//  Copyright (c) 2014 Charly DELAROCHE. All rights reserved.
//

import Foundation

class Vector2
{
    var x: Double
    
    var y: Double
    
    
    init()
    {
        x = 0
        y = 0
    }
    init(fromPosx x:Double, andY y:Double)
    {
        self.x = x
        self.y = y
    }
    func distanceBetween(anotherPoint p:Vector2) -> Double
    {
        return sqrt((p.x - x) * (p.x - x) + (p.y - y) * (p.y - y))
    }
    func dotProductwithVector(anotherPoint p:Vector2) -> Double
    {
        return p.x * x + p.y * y;
    }
    var description: String
        {
            return "\(x)-\(y)"
    }
}

func ==(lhs: Vector2, rhs: Vector2) -> Bool
{
    return lhs.x == rhs.x && lhs.y == rhs.y
}
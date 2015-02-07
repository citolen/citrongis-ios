//
//  Extent.swift
//  CitronGIS
//
//  Created by Charly DELAROCHE on 2/5/15.
//  Copyright (c) 2015 Charly DELAROCHE. All rights reserved.
//

import Foundation

class Extent {
    var minX:Double = 0
    var minY:Double = 0
    var maxX:Double = 0
    var maxY:Double = 0
    
    init(minX:Double, andMinY minY:Double, andMaxX maxX:Double, andMaxY maxY:Double)
    {
        self.minX = minX
        self.maxX = maxX
        self.minY = minY
        self.maxY = maxY
    }
}


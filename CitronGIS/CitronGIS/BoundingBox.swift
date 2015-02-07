//
//  BoundingBox.swift
//  CitronGIS
//
//  Created by Charly DELAROCHE on 2/5/15.
//  Copyright (c) 2015 Charly DELAROCHE. All rights reserved.
//

import Foundation

class BoundingBox {
    var topLeft = Vector2()
    var topRight = Vector2()
    var botRight = Vector2()
    var botLeft = Vector2()
    
    init()
    {
        
    }
    init(topLeft:Vector2, andTopRight topRight:Vector2, andBotRight botRight:Vector2, andBotLeft botLeft:Vector2)
    {
        self.topLeft = topLeft
        self.topRight = topRight
        self.botRight = botRight
        self.botLeft = botLeft
    }
    func center() -> Vector2
    {
        return Vector2(fromPosx: (topLeft.x + topRight.x + botRight.x + botLeft.x) / 4, andY: (topLeft.y + topRight.y + botRight.y + botLeft.y) / 4)
    }
}

func ==(lhs: BoundingBox, rhs: BoundingBox) -> Bool
{
    return  lhs.topLeft == rhs.topLeft &&
            lhs.topRight == rhs.topRight &&
            lhs.botLeft == rhs.botLeft &&
            lhs.botRight == rhs.botRight
}
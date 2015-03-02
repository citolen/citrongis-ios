//
//  SchemaBase.swift
//  CitronGIS
//
//  Created by Charly DELAROCHE on 2/5/15.
//  Copyright (c) 2015 Charly DELAROCHE. All rights reserved.
//

import Foundation

class SchemaBase {
    let name:String
    let crs:Projection
    let originX:Double
    let originY:Double
    let extent:Extent
    
    init(name:String, andCrs crs:Projection, withOriginX originX:Double, withOriginY originY:Double, andBoudingBox extent:Extent)
    {
        self.name = name
        self.crs = crs
        self.originX = originX
        self.originY = originY
        self.extent = extent
    }
    
    func translate(viewport:Viewport, tx:Double, ty:Double)
    {
        fatalError("To Implement")
    }
    func setTranslation(viewport:Viewport, tx:Double, ty:Double)
    {
        fatalError("To Implement")
    }
    func rotate(viewport:Viewport, angle:Double)
    {
        fatalError("To Implement")
    }
    func update(viewport:Viewport)
    {
        fatalError("To Implement")
    }
    func screenToWorld(viewport:Viewport, px:UInt, py:UInt) -> Vector2
    {
        fatalError("To Implement")
    }
    func worldToScreen(viewport:Viewport, wx:Double, wy:Double) -> Vector2
    {
        fatalError("To Implement")
    }
}
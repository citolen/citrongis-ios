//
//  Viewport.swift
//  CitronGIS
//
//  Created by Charly DELAROCHE on 2/5/15.
//  Copyright (c) 2015 Charly DELAROCHE. All rights reserved.
//

import Foundation

class Viewport
{
    var width:UInt = 0
    var height:UInt = 0
    var resolution:Double = 0
    var schema:SchemaBase
    var rotation:Double = 0
    var boundingBox:BoundingBox = BoundingBox()
    var origin:Vector2
    var scaleFactor = CCDirector.sharedDirector().contentScaleFactor
    
    init(width:UInt, andHeight height:UInt, andResolution resolution:Double, andSchema schema:SchemaBase, andOrigin origin:Vector2, andRotation rotation:Double)
    {
        self.width = width
        self.height = height
        self.resolution = resolution
        self.schema = schema
        self.rotation = rotation
        self.origin = origin
        self.schema.update(self)
    }
    
    func translate(tx:Double, ty:Double)
    {
        schema.translate(self, tx: tx, ty: ty)
        schema.update(self)
    }
    func setTranslation(tx:Double, ty:Double)
    {
        schema.setTranslation(self, tx: tx, ty: ty)
        schema.update(self)
    }
    func rotate(angle:Double)
    {
        schema.rotate(self, angle: angle)
        schema.update(self)
    }
    func zoomT(resolution:Double)
    {
        self.resolution += resolution
        schema.update(self)
    }
    func zoom(resolution:Double)
    {
        self.resolution = resolution
        schema.update(self)
    }
    
    func resize(width:UInt, height:UInt)
    {
        self.width = width
        self.height = height
        schema.update(self)
    }
    
    func screenToWorld(px:UInt, py:UInt) -> Vector2
    {
        return schema.screenToWorld(self, px: px, py: py)
    }
    
    func worldToScreen(wx:Double, wy:Double) -> Vector2
    {
        return schema.worldToScreen(self, wx: wx, wy: wy)
    }
    
    
}
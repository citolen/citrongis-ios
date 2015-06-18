//
//  Viewport.swift
//  CitronGIS
//
//  Created by Charly DELAROCHE on 2/5/15.
//  Copyright (c) 2015 Charly DELAROCHE. All rights reserved.
//

import Foundation

var VIEWPORT:Viewport!

enum ZoomDirection {
    case In
    case Out
}


class Viewport
{
    var zoomDirection = ZoomDirection.Out
    var width:UInt = 0
    var height:UInt = 0
    var resolution:Double = 0
    var rotation = 0.0
    var schema:SchemaBase
    var boundingBox:BoundingBox = BoundingBox()
    var origin:Vector2
    var scaleFactor = CCDirector.sharedDirector().contentScaleFactor
    var onResolutionChange:[String:() -> Void] = [:]
    var onMove:[String:() -> Void] = [:]
    
    init(width:UInt, andHeight height:UInt, andResolution resolution:Double, andSchema schema:SchemaBase, andOrigin origin:Vector2, andRotation rotation:Double)
    {
        self.width = width
        self.height = height
        self.resolution = resolution
        self.schema = schema
        self.rotation = rotation
        self.origin = origin
        self.schema.update(self)
        VIEWPORT = self
    }
    
    func registerToEventResolutionChange(block: () -> Void, key:String)
    {
        onResolutionChange[key] = block
    }
    func unregisterToEventResolutionChange(key:String)
    {
        onResolutionChange.removeValueForKey(key)
    }
    private func throwEventResolutionChange()
    {
        for (key, value) in onResolutionChange
        {
            value()
        }
    }
    func registerToEventMove(block: () -> Void, key:String)
    {
        onMove[key] = block
    }
    func unregisterToEventMove(key:String)
    {
        onMove.removeValueForKey(key)
    }
    private func throwEventMove()
    {
        for (key, value) in onMove
        {
            value()
        }
    }
    
    
    func translate(tx:Double, ty:Double)
    {
        schema.translate(self, tx: tx, ty: ty)
        schema.update(self)
        self.throwEventMove()
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
        println("\(self.resolution)")
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
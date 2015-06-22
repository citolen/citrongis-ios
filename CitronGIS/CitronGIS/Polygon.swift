//
//  Polygon.swift
//  CitronGIS
//
//  Created by Charly DELAROCHE on 3/3/15.
//  Copyright (c) 2015 Charly DELAROCHE. All rights reserved.
//

import Foundation

class Polygon: Feature {
    var locations:[GeometryPoint] = []
    var borderColor:CCColor = CCColor.blueColor()
    var fillColor:CCColor = CCColor.clearColor()
    var borderWidth:Double = 2
    var node:CCDrawNode!
    var radius:Double = 5.0
    
    override init() {
        super.init()
        node = CCDrawNode()
        node.anchorPoint = ccp(0.5, 0.5)
        node.zOrder = 1
    }
    
    func addVertex(pt:GeometryPoint)
    {
        locations.append(pt)
    }
    
    func updateDraw(renderer:CocosRenderer)
    {
        node.clear()
        var pt:[CGPoint] = []
        for loc in locations
        {
            pt.append(renderer.getLocationOfPoint(loc))
        }
        
        var bb = pt.withUnsafeBufferPointer { (cArray: UnsafeBufferPointer<CGPoint>) -> UnsafePointer<CGPoint> in
            return cArray.baseAddress

        }
        
        self.node.drawPolyWithVerts(bb, count: UInt(pt.count), fillColor:self.fillColor, borderWidth:CGFloat(self.borderWidth), borderColor: self.borderColor)
    }
    
    func setColor(color:CCColor)
    {
        self.fillColor = color
        self.setDirty()
    }
    func setBorderColor(borderColor:CCColor)
    {
        self.borderColor = borderColor
        self.setDirty()
    }
    func setBorderWidth(borderWidth:Double)
    {
        self.borderWidth = borderWidth
        self.setDirty()
    }
    override func render(renderer:CocosRenderer ) {
        self.updateDraw(renderer)
    }
    
    override func addToScene(renderer: CocosRenderer) {
        renderer.scene.addChild(node)
        self.updateDraw(renderer)
    }
    
}
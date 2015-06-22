//
//  Circle.swift
//  CitronGIS
//
//  Created by Charly DELAROCHE on 2/5/15.
//  Copyright (c) 2015 Charly DELAROCHE. All rights reserved.
//

import Foundation

class Circle : Feature {
    var location:GeometryPoint = GeometryPoint()
    var borderColor:CCColor = CCColor.blueColor()
    var fillColor:CCColor = CCColor.clearColor()
    var borderWidth:Double = 0
    var node:CCDrawNode!
    var radius:Double = 5.0
    
    override init() {
        super.init()
        node = CCDrawNode()
        node.anchorPoint = ccp(0.5, 0.5)
        node.zOrder = 1
        updateDraw()
    }
    func updateDraw()
    {
        node.clear()
        if (borderWidth > 0)
        {
            node.drawDot(ccp(0, 0), radius: CGFloat(radius + borderWidth), color: borderColor)
        }
        node.drawDot(ccp(0, 0), radius: CGFloat(radius), color: fillColor)
    }
    
    func setLocation(location:GeometryPoint)
    {
        self.location = location
        self.setDirty()
    }
    func setColor(color:CCColor)
    {
        self.fillColor = color
        self.updateDraw()
    }
    func setRadius(size:Double)
    {
        radius = size
        self.updateDraw()
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
        node.position = renderer.getLocationOfPoint(location)
    }
    
    override func addToScene(renderer: CocosRenderer) {
        renderer.scene.addChild(node)
    }
}
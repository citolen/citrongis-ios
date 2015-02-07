//
//  Circle.swift
//  CitronGIS
//
//  Created by Charly DELAROCHE on 2/5/15.
//  Copyright (c) 2015 Charly DELAROCHE. All rights reserved.
//

import Foundation

class Rect : Feature {
    var location:GeometryPoint = GeometryPoint()
    var borderColor:CCColor = CCColor.blueColor()
    var borderWidth:Double = 0
    
    var node:CCNodeColor!
    
    override init() {
        super.init()
        node = CCNodeColor(color: CCColor.redColor(), width: 10, height: 10)
    }
    
    func setLocation(location:GeometryPoint)
    {
        self.location = location
        self.setDirty()
    }
    func setColor(color:CCColor)
    {
        node.color = color
    }
    func setSize(size:CGSize)
    {
        self.node.contentSize = size
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
        println("\(node.position.x), \(node.position.y)")
    }
    override func addToScene(renderer: CocosRenderer) {
        renderer.scene.addChild(node)
    }
}
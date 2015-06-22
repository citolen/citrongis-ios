//
//  Polyline.swift
//  CitronGIS
//
//  Created by Charly DELAROCHE on 4/5/15.
//  Copyright (c) 2015 Charly DELAROCHE. All rights reserved.
//

import Foundation

class Polyline: Feature {
    var locations:[GeometryPoint] = []
    var fillColor:CCColor = CCColor.clearColor()
    var lineWidth = 2.0
    var node:CCDrawNode!
    
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
        
        if (locations.count == 0)
        {
            return
        }
        var pts:[CGPoint] = []
        for loc in locations
        {
            pts.append(renderer.getLocationOfPoint(loc))
        }
        
        var oldPt = pts.first!
        
        for index in 1...pts.count - 1 {
            var cur = pts[index]
            
            self.node.drawSegmentFrom(oldPt, to: cur, radius: CGFloat(lineWidth), color: self.fillColor)
            
            oldPt = cur
        }
    }
    func setLineWidth(lineWidth:Double)
    {
        self.lineWidth = lineWidth
        self.setDirty()
    }
    
    func setColor(color:CCColor)
    {
        self.fillColor = color
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
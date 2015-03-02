//
//  CocosRenderer.swift
//  CitronGIS
//
//  Created by Charly DELAROCHE on 2/5/15.
//  Copyright (c) 2015 Charly DELAROCHE. All rights reserved.
//

import Foundation

class CocosRenderer: RendererBase {
    var dirtyFeatures:[Feature] = []
    var scene:CCScene = CCDirector.sharedDirector().runningScene
    
    override func featureChanged(feature: Feature, type: EventType) {
        if (type == EventType.Added)
        {
            feature.addToScene(self)
            feature.render(self)
        }
    }
    
    override func getLocationOfPoint(p: GeometryPoint) -> CGPoint {
        var l:GeometryPoint = CoordinateHelper.transformTo(p, proj: self.viewPort.schema.crs)
        
        var pos = self.viewPort.worldToScreen(l.x, wy:l.y)
        return CGPointMake(CGFloat(pos.x), CGFloat(Double(self.viewPort.height) - pos.y))
    }
    
    override func updatePositions(manager:LayerManager) {
        for grp in manager.groups
        {
            for layer in grp.layers
            {
                for feature in layer.features
                {
                    feature.render(self)
                }
            }
        }
    }
}
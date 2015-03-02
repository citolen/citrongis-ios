//
//  RendererBase.swift
//  CitronGIS
//
//  Created by Charly DELAROCHE on 2/5/15.
//  Copyright (c) 2015 Charly DELAROCHE. All rights reserved.
//

import Foundation

class RendererBase {
    let layerManager:LayerManager
    let stage:CCScene
    let viewPort:Viewport
    
    init(layerManager:LayerManager, andScene scene:CCScene, andViewPort viewPort:Viewport)
    {
        self.layerManager = layerManager
        self.stage = scene
        self.viewPort = viewPort
        
        layerManager.registerToEventFeatureChanged({ (feature:Feature, type:EventType) -> Void in
            self.featureChanged(feature, type: type)
            }, key: "renderRegister")
        
        layerManager.registerToEventLayerChanged({ (layer:Layer, type:EventType) -> Void in
            
            }, key: "renderLayerChanged")
        
        layerManager.registerToGroupChanged({ (group:Group, type:EventType) -> Void in
            
            }, key: "renderGroupChanged")
    }
    func featureChanged(feature:Feature, type:EventType)
    {
        fatalError("To Implement")
    }
    func layerChanged(layer:Layer, type:EventType)
    {
        fatalError("To Implement")
    }
    func groupChanged(group:Group, type:EventType)
    {
        fatalError("To Implement")
    }
    func updatePositions(manager:LayerManager)
    {
        fatalError("To Implement")
    }
    func renderFrame()
    {
        fatalError("To Implement")
    }
    func getLocationOfPoint(p:GeometryPoint) -> CGPoint
    {
        fatalError("To Implement")
    }
    
}
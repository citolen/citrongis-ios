//
//  Group.swift
//  CitronGIS
//
//  Created by Charly DELAROCHE on 2/5/15.
//  Copyright (c) 2015 Charly DELAROCHE. All rights reserved.
//

import Foundation


class Group {
    var name = ""
    //Toadd Proprio (extension)
    var layers:[Layer] = []
    
    //Events
    var layerAdded:[String:(Layer) -> Void] = [:]
    var layerRemoved:[String:(Layer) -> Void] = [:]
    var layerMoved:[String:(Layer) -> Void] = [:]
    var layerChanged:[String:(Layer, EventType) -> Void] = [:]
    var featureChanged:[String:(Feature, EventType) -> Void] = [:]
    
    
    func registerToEventLayerAdded(block: (Layer) -> Void, key:String)
    {
        layerAdded[key] = block
    }
    func unregisterToEventFeatureAdded(key:String)
    {
        layerAdded.removeValueForKey(key)
    }
    private func throwEventLayerAdded(layer:Layer)
    {
        for (key, value) in layerAdded
        {
            value(layer)
        }
        self.throwEventLayerChanged(layer, type: EventType.Added)
    }
    
    func registerToEventFeatureRemoved(block: (Layer) -> Void, key:String)
    {
        layerRemoved[key] = block
    }
    func unregisterToEventLayerRemoved(key:String)
    {
        layerRemoved.removeValueForKey(key)
    }
    private func throwEventLayerRemoved(layer:Layer)
    {
        for (key, value) in layerRemoved
        {
            value(layer)
        }
        self.throwEventLayerChanged(layer, type: EventType.Removed)
    }
    
    func registerToEventFeatureMoved(block: (Layer) -> Void, key:String)
    {
        layerMoved[key] = block
    }
    func unregisterToEventLayerMoved(key:String)
    {
        layerMoved.removeValueForKey(key)
    }
    private func throwEventLayerMoved(layer:Layer)
    {
        for (key, value) in layerMoved
        {
            value(layer)
        }
        self.throwEventLayerChanged(layer, type: EventType.Moved)
    }
    
    func registerToEventLayerChanged(block: (Layer, EventType) -> Void, key:String)
    {
        layerChanged[key] = block
    }
    func unregisterToEventLayerChanged(key:String)
    {
        layerChanged.removeValueForKey(key)
    }
    private func throwEventLayerChanged(layer:Layer, type:EventType)
    {
        for (key, value) in layerChanged
        {
            value(layer, type)
        }
    }
    
    func registerToEventFeatureChanged(block: (Feature, EventType) -> Void, key:String)
    {
        featureChanged[key] = block
    }
    func unregisterToEventFeatureChanged(key:String)
    {
        featureChanged.removeValueForKey(key)
    }
    private func throwEventFeatureChanged(feature:Feature, type:EventType)
    {
        for (key, value) in featureChanged
        {
            value(feature, type)
        }
    }
    
    func addLayer(layer:Layer)
    {
        layers.append(layer)
        layer.registerToEventLayerDirty({ (layer:Layer) -> Void in
            self.throwEventLayerChanged(layer, type: EventType.Dirty)
        }, key: "LayerFeatureDirty")
        layer.registerToEventFeatureChanged({ (feature:Feature, type:EventType) -> Void in
            self.throwEventFeatureChanged(feature, type: type)
        }, key: "LayerEventFeatureChanged")
        throwEventLayerAdded(layer)
    }
}
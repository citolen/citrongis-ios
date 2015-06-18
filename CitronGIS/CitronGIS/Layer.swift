//
//  Layer.swift
//  CitronGIS
//
//  Created by Charly DELAROCHE on 2/5/15.
//  Copyright (c) 2015 Charly DELAROCHE. All rights reserved.
//

import Foundation

class Layer {
    var name = ""
    //Proprio (extension)
    var group:Group! = nil;
    var features:[Feature] = []
    var enabled:Bool = true
    var opacity:Float = 1.0
    var isDirty:Bool = true
    
    //Events
    var featureAdded:[String:(Feature) -> Void] = [:]
    var featureRemoved:[String:(Feature) -> Void] = [:]
    var featureChanged:[String:(Feature, EventType) -> Void] = [:]
    var featureDirty:[String:(Feature) -> Void] = [:]
    var layerDirty:[String:(Layer) -> Void] = [:]
    
    func registerToEventFeatureAdded(block: (Feature) -> Void, key:String)
    {
        featureAdded[key] = block
    }
    func unregisterToEventFeatureAdded(key:String)
    {
        featureAdded.removeValueForKey(key)
    }
    private func throwEventFeatureAdded(feature:Feature)
    {
        for (key, value) in featureAdded
        {
            value(feature)
        }
        self.throwEventFeatureChanged(feature, type: EventType.Added)
    }
    
    func registerToEventFeatureRemoved(block: (Feature) -> Void, key:String)
    {
        featureRemoved[key] = block
    }
    func unregisterToEventFeatureRemoved(key:String)
    {
        featureRemoved.removeValueForKey(key)
    }
    private func throwEventFeatureRemoved(feature:Feature)
    {
        for (key, value) in featureRemoved
        {
            value(feature)
        }
        self.throwEventFeatureChanged(feature, type:EventType.Removed)
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
    
    func registerToEventFeatureDirty(block: (Feature) -> Void, key:String)
    {
        featureDirty[key] = block
    }
    func unregisterToEventFeatureDirty(key:String)
    {
        featureDirty.removeValueForKey(key)
    }
    private func throwEventDirty(feature:Feature)
    {
        for (key, value) in featureDirty
        {
            value(feature)
        }
        self.throwEventFeatureChanged(feature, type:EventType.Dirty)
    }
    
    func registerToEventLayerDirty(block: (Layer) -> Void, key:String)
    {
        layerDirty[key] = block
    }
    func unregisterToEventLayerDirty(key:String)
    {
        featureDirty.removeValueForKey(key)
    }
    private func throwEventLayerDirty()
    {
        for (key, value) in layerDirty
        {
            value(self)
        }
//        Todo
//        self.throwEventLayerChanged(self, type:EventType.Dirty)
    }
    
    func addFeature(feature:Feature)
    {
        features.append(feature)
        
        feature.registerToEventDirty({ (feature:Feature) -> Void in
            self.throwEventDirty(feature)
        }, key: "FeatureDirty")
        throwEventFeatureAdded(feature)
    }
    func removeFeature(feature:Feature) -> Bool
    {
        for var i = 0; i < features.count; ++i
        {
            let f = features[i]
            
            if f === feature {
                features.removeAtIndex(i)
                self.throwEventFeatureChanged(f, type: EventType.Removed)
                self.throwEventFeatureRemoved(f)
                return true
            }
        }
        return false
//        for f in features
//        {
//            features.rem
//        }
    }
    func onRemove()
    {
        
    }
    func onAdd()
    {
        
    }
    func setDirty()
    {
        isDirty = true
        self.throwEventLayerDirty()
    }
}
//
//  LayerManager.swift
//  CitronGIS
//
//  Created by Charly DELAROCHE on 2/5/15.
//  Copyright (c) 2015 Charly DELAROCHE. All rights reserved.
//

import Foundation

class LayerManager {
    var groups:[Group] = []
    
    //Events
    var groupCreated:[String:(Group) -> Void] = [:]
    var groupDeleted:[String:(Group) -> Void] = [:]
    var groupMoved:[String:(Group) -> Void] = [:]
    var groupChanged:[String:(Group, EventType) -> Void] = [:]
    var featureChanged:[String:(Feature, EventType) -> Void] = [:]
    var layerChanged:[String:(Layer, EventType) -> Void] = [:]
    
    
    func registerToGroupCreated(block: (Group) -> Void, key:String)
    {
        groupCreated[key] = block
    }
    func unregisterToGroupCreated(key:String)
    {
        groupCreated.removeValueForKey(key)
    }
    private func throwEventGroupCreated(group:Group)
    {
        for (key, value) in groupCreated
        {
            value(group)
        }
        self.throwEventGroupChanged(group, type:EventType.Created)
    }
    
    func registerToGroupDeleted(block: (Group) -> Void, key:String)
    {
        groupDeleted[key] = block
    }
    func unregisterToGroupDeleted(key:String)
    {
        groupDeleted.removeValueForKey(key)
    }
    private func throwEventGroupDeleted(group:Group)
    {
        for (key, value) in groupDeleted
        {
            value(group)
        }
        self.throwEventGroupChanged(group, type:EventType.Deleted)
    }
    
    func registerToGroupMoved(block: (Group) -> Void, key:String)
    {
        groupMoved[key] = block
    }
    func unregisterToGroupMoved(key:String)
    {
        groupMoved.removeValueForKey(key)
    }
    private func throwEventGroupMoved(group:Group)
    {
        for (key, value) in groupMoved
        {
            value(group)
        }
        self.throwEventGroupChanged(group, type:EventType.Moved)
    }
    
    func registerToGroupChanged(block: (Group, EventType) -> Void, key:String)
    {
        groupChanged[key] = block
    }
    func unregisterToGroupChanged(key:String)
    {
        groupChanged.removeValueForKey(key)
    }
    private func throwEventGroupChanged(group:Group, type:EventType)
    {
        for (key, value) in groupChanged
        {
            value(group, type)
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
    
    func registerToEventLayerChanged(block: (Layer, EventType) -> Void, key:String)
    {
        layerChanged[key] = block
    }
    func unregisterToEventLayerChanged(key:String)
    {
        layerChanged.removeValueForKey(key)
    }
    private func throwEventLayerChanged(layer:Layer, type: EventType)
    {
        for (key, value) in layerChanged
        {
            value(layer, type)
        }
    }
    
    func addGroup(group: Group)
    {
        groups.append(group)
        group.registerToEventFeatureChanged({ (feature:Feature, type:EventType) -> Void in
            self.throwEventFeatureChanged(feature, type: type)
        }, key: "testGroupFeatureChanged")
        group.registerToEventLayerChanged({ (layer:Layer, type:EventType) -> Void in
            self.throwEventLayerChanged(layer, type: type)
        }, key: "testGroupLayerChanged")
        
        throwEventGroupCreated(group)
    }
}
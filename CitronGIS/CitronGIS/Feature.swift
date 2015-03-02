//
//  Feature.swift
//  CitronGIS
//
//  Created by Charly DELAROCHE on 2/5/15.
//  Copyright (c) 2015 Charly DELAROCHE. All rights reserved.
//

import Foundation

class Feature {
    //Members
    var isDirty:Bool = true
    var mask:CLong = 0
    
    init()
    {
        self.isDirty = true
    }
    
    func setDirty()
    {
        isDirty = true
        self.throwEventDirty()
    }
    
    //Events
    var eventDirty:[String:(Feature) -> Void] = [:]
    
    func registerToEventDirty(block: (Feature) -> Void, key:String)
    {
        eventDirty[key] = block
    }
    func unregisterToEventDirty(key:String)
    {
        eventDirty.removeValueForKey(key)
    }
    
    private func throwEventDirty()
    {
        for (key, value) in eventDirty
        {
            value(self)
        }
    }
    
    func render(renderer:CocosRenderer)
    {
        
    }
    func addToScene(renderer:CocosRenderer)
    {
        
    }
    
}
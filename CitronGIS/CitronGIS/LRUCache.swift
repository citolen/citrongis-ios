//
//  LRUCache.swift
//  CitronGIS
//
//  Created by Charly DELAROCHE on 6/16/15.
//  Copyright (c) 2015 Charly DELAROCHE. All rights reserved.
//

import Foundation

class LRUCache<T:Hashable, S> {
    private var _cache = Dictionary<T, S>()
    
    func add(key:T, value:S)
    {
        _cache[key] = value
    }
    
    func get(key:T) -> S!
    {
        return _cache[key]
    }
    
    
    
}
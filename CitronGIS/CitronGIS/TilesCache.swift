//
//  TilesCache.swift
//  CitronGIS
//
//  Created by Charly DELAROCHE on 6/21/15.
//  Copyright (c) 2015 Charly DELAROCHE. All rights reserved.
//

import Foundation

class TilesCache
{
    var _cache = LRUCache<Int64, (Image, TileIndex, Int)>(capacity: 50)
    
    subscript (key:Int64) -> (Image, TileIndex, Int)! {
        get {
            return _cache.get(key)
        }
        set(newValue) {
            add(key, value: newValue)
        }
    }
    func add(key:Int64, value:(Image, TileIndex, Int))
    {
        if let deleted = _cache.add(key, value: value) {
//            deleted.1.0.node.spriteFrame.texture = nil
        }
    }
}
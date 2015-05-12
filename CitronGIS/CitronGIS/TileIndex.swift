//
//  TileIndex.swift
//  CitronGIS
//
//  Created by Charly DELAROCHE on 5/11/15.
//  Copyright (c) 2015 Charly DELAROCHE. All rights reserved.
//

import Foundation

class TileIndex {
    var _BId = Int64(0)
    var _x = 0.0
    var _y = 0.0
    var _z = 0.0
    
    init(x:Double, y:Double, z:Double, bid:Int64)
    {
        _x = x
        _y = y
        _z = z
        _BId = bid
    }
    init(x:Double, y:Double, z:Double)
    {
        _x = x
        _y = y
        _z = z
        _BId = TileIndex.createBid(x, y: y, z: z)
    }
    
    init(BId:Int64)
    {
        _x = Double(((BId << 16) >> 40))
        _y = Double(((BId << 40) >> 40))
        _z = Double((BId >> 48))
        _BId = BId
    }
    
    func positionInTiles(tile:TileIndex) -> Vector3!
    {
        if (_z >= tile._z)
        {
            return nil
        }
        var dZ = Int64(tile._z - _z)
        var pZ = Double(1 << dZ)
        
        return Vector3(fromPosx: tile._x / pZ - _x, andY:tile._y / pZ - _y, andZ: pZ)
    }
    
    func levelUp() -> TileIndex
    {
        if (_z == 0)  {
            return self
        }
        
        var z = _z - 1
        var x = floor(_x / 2.0)
        var y = floor(_y / 2.0)
        return TileIndex(x: x, y: y, z: z)
    }
    func levelDown() -> [TileIndex]
    {
        var z = _z + 1
        var x = _x * 2
        var y = _y * 2
        
        return [TileIndex(x: x, y: y, z: z),
                TileIndex(x: x + 1, y: y, z: z),
                TileIndex(x: x, y: y + 1, z: z),
                TileIndex(x: x + 1, y: y + 1, z: z)]
    }
    
    class func createBid(x:Double, y:Double, z:Double) -> Int64
    {
        var xI = Int64(x)
        var yI = Int64(y)
        var zI = Int64(z)
        
        xI = xI + ((xI < 0) ? (16777216) : (0))
        yI = yI + ((yI < 0) ? (16777216) : (0))
        
        
        var re = Int64(((yI << 40) >> 40) | ((xI << 40) >> 16) | (zI << 48))
        
        return re
    }
}
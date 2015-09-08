//
//  TileSphericalMercator.swift
//  CitronGIS
//
//  Created by Charly DELAROCHE on 5/11/15.
//  Copyright (c) 2015 Charly DELAROCHE. All rights reserved.
//

import Foundation

enum yAxisMode
{
    case Normal
    case Inverted
}

class TileSchema
{
    let _tileWidth:Double
    let _tileHeight:Double
    let _yAxisType:yAxisMode
    let _resolutions:[Double]
    let _originX:Double
    let _originY:Double
    var _extent:Extent = Extent(minX: 0.0, andMinY: 0.0, andMaxX: 0.0, andMaxY: 0.0)
    var _bounds:[Int]
    var _resolution:Double
    var _unchangedTiles = [Int64: TileIndex]()
    var _removedTiles = [Int64: TileIndex]()
    var _addedTiles = [Int64: TileIndex]()
    var _onAddTiles:[String:([Int64: TileIndex]) -> Void] = [:]
    var _onRegister:[String:() -> Void] = [:]
    var _onUnRegister:[String:() -> Void] = [:]
    var _onRemoveTiles:[String:([Int64: TileIndex]) -> Void] = [:]
    
    init(tileWidth:Double, tileHeight:Double, yAxisType:yAxisMode, resolutions:[Double], originX:Double, originY:Double, bounds:[Int], resolution:Double)
    {
        _tileWidth = tileWidth
        _tileHeight = tileHeight
        _yAxisType = yAxisType
        _resolutions = resolutions
        _originX = originX
        _originY = originY
        _bounds = bounds
        _resolution = resolution
        self.calculeBounds()
    }
    init(extent:Extent, tileWidth:Double, tileHeight:Double, yAxisType:yAxisMode, resolutions:[Double], originX:Double, originY:Double, bounds:[Int], resolution:Double)
    {
        _extent = extent
        _tileWidth = tileWidth
        _tileHeight = tileHeight
        _yAxisType = yAxisType
        _resolutions = resolutions
        _originX = originX
        _originY = originY
        _bounds = bounds
        _resolution = resolution
        self.calculeBounds()
    }
    func registerForEventRegister(block: ()->Void, key:String)
    {
        _onRegister[key] = block
    }
    func unregisterForRegister(key:String)
    {
        _onRegister.removeValueForKey(key)
    }
    func throwEventRegister()
    {
        for (key, value) in _onRegister
        {
            value()
        }
    }
    
    func registerForEventUnRegister(block: ()->Void, key:String)
    {
        _onUnRegister[key] = block
    }
    func unregisterForUnRegister(key:String)
    {
        _onUnRegister.removeValueForKey(key)
    }
    func throwEventUnRegister()
    {
        for (key, value) in _onUnRegister
        {
            value()
        }
    }
    
    func registerToEventAddTiles(block: ([Int64: TileIndex]) -> Void, key:String)
    {
        _onAddTiles[key] = block
    }
    func unregisterToEventAddTiles(key:String)
    {
        _onAddTiles.removeValueForKey(key)
    }
    private func throwEventAddTiles()
    {
        for (key, value) in _onAddTiles
        {
            value(_addedTiles)
        }
    }
    
    func registerToEventRemoveTiles(block: ([Int64: TileIndex]) -> Void, key:String)
    {
        _onRemoveTiles[key] = block
    }
    func unregisterToEventRemoveTiles(key:String)
    {
        _onRemoveTiles.removeValueForKey(key)
    }
    private func throwEventRemoveTiles()
    {
        for (key, value) in _onRemoveTiles
        {
            value(_removedTiles)
        }
    }
    
    
    func tileToWorld(index:TileIndex, resolution:Double, size:Double, anchor:Double = 0.5) -> Vector2
    {
        fatalError("To Implement")
    }
    
    func worldToTile(world:Vector2, resolution:Double, size:Double) -> TileIndex
    {
        return TileIndex(x: 0, y: 0, z: 0)
    }
    
    func calculeBounds()
    {
        for (var i = 0; i < _resolutions.count; ++i)
        {
            let bits = 1 << i
            _bounds.append(bits)
        }
        
        
    }
    func getZoomLevel(resolution:Double) -> Int
    {
        for (var i = 0; i < _resolutions.count; ++i)
        {
            var res = _resolutions[i];
            
            if (resolution > res || abs(resolution - res) < 0.0001)
            {
                return i > 0 ? i - 1 : 0
            }
        }
        return _resolutions.count - 1
    }
    
    func fitToBounds(point:TileIndex, bound:Double, shouldFloor:Bool)
    {
        if (shouldFloor)
        {
            point._x = floor(point._x)
            point._y = floor(point._y)
        }
        point._x = max(point._x, 0.0)
        point._y = max(point._y, 0.0)
        point._x = min(point._x, bound)
        point._y = min(point._y, bound)
    }
    
    func mergeTiles()
    {
        for (key, img) in _addedTiles
        {
            _unchangedTiles[key] = img
        }
    }
    
    func getCurrentTiles() -> [Int64: TileIndex]
    {
        var re = [Int64: TileIndex]()
        
        for (key, img) in _addedTiles
        {
            re[key] = img
        }
        for (key, img) in _unchangedTiles
        {
            re[key] = img
        }
        return re
    }
    
    func isTileInView(index:TileIndex) -> Bool
    {
        if (_unchangedTiles[index._BId] != nil)
        {
            return true
        }
        if (_addedTiles[index._BId] != nil)
        {
            return true
        }
        return false
    }
    func tileToPoly(tile:TileIndex, resolution:Double, size:Double) -> [Vector2]
    {
        let x = floor(tile._x)
        let y = floor(tile._y)
  
        let tcenter = tileToWorld(TileIndex(x: x + 0.5, y: y + 0.5, z: tile._z, bid: tile._BId), resolution: resolution, size: size, anchor:0.0)
        let half = (size / 2) * resolution;
        let topLeft = Vector2(fromPosx: tcenter.x - half, andY: tcenter.y + half)
        let topRight = Vector2(fromPosx: tcenter.x + half, andY: tcenter.y + half)
        let bottomLeft = Vector2(fromPosx: tcenter.x - half, andY: tcenter.y - half)
        let bottomRight = Vector2(fromPosx: tcenter.x + half, andY: tcenter.y - half)
        
        return [topLeft, topRight, bottomRight, bottomLeft]
    }
    
    
    func computeTile(viewport:Viewport)
    {
        if (viewport.rotation != 0)
        {
            var zoom = self.getZoomLevel(viewport.resolution)
            _resolution = _resolutions[zoom]
            let size = Double(_resolution) / Double(viewport.resolution) * Double(_tileWidth)
            let bound = Double(_bounds[zoom])

            self.mergeTiles()
            
            _addedTiles.removeAll(keepCapacity: true)
            _removedTiles.removeAll(keepCapacity: true)
            
            var tiles = [Int64: TileIndex]()

            

            let bbox = [self.worldToTile(VIEWPORT.boundingBox.topLeft, resolution: VIEWPORT.resolution, size: size), self.worldToTile(VIEWPORT.boundingBox.topRight, resolution: VIEWPORT.resolution, size: size), self.worldToTile(VIEWPORT.boundingBox.botRight, resolution: VIEWPORT.resolution, size: size), self.worldToTile(VIEWPORT.boundingBox.botLeft, resolution: VIEWPORT.resolution, size: size)]
            
            
            var minX = Double.infinity
            var maxX = 0.0
            var minY = Double.infinity
            var maxY = 0.0
            
            for l in bbox {
                minX = min(l._x, minX)
                maxX = max(l._x, maxX)
                minY = min(l._y, minY)
                maxY = max(l._y, maxY)
            }
            minX = floor(minX)
            maxX = ceil(maxX)
            minY = floor(minY)
            maxY = ceil(maxY)
            
            for var y = minY; y < maxY; ++y {
                for var x = minX; x < maxX; ++x {
                    var tile = TileIndex(x: x, y: y, z: bbox[0]._z)
                    tiles[tile._BId] = tile
                    if _unchangedTiles[tile._BId] == nil {
                        _addedTiles[tile._BId] = tile
                    }
                }
            }
            
            for key in _unchangedTiles {
                if (tiles[key.0] == nil) {
                    _removedTiles[key.0] = _unchangedTiles[key.0]
                    _unchangedTiles.removeValueForKey(key.0)
                }
            }
            
            if (_removedTiles.count > 0) {
                throwEventRemoveTiles()
            }
            if (_addedTiles.count > 0) {
                throwEventAddTiles()
            }

        }
        else
        {
            var zoom = self.getZoomLevel(viewport.resolution)
            _resolution = _resolutions[zoom]
            
            var size = _resolution / VIEWPORT.resolution * _tileWidth
            
            
            var topLeft = self.worldToTile(VIEWPORT.boundingBox.topLeft, resolution: VIEWPORT.resolution, size: size)
            var topRight = self.worldToTile(VIEWPORT.boundingBox.topRight, resolution: VIEWPORT.resolution, size: size)
            var bottomRight = self.worldToTile(VIEWPORT.boundingBox.botRight, resolution: VIEWPORT.resolution, size: size)
            var bottomLeft = self.worldToTile(VIEWPORT.boundingBox.botLeft, resolution: VIEWPORT.resolution, size: size)
            
            var bound = Double(_bounds[zoom])
            
            self.fitToBounds(topLeft, bound: bound, shouldFloor: true)
            self.fitToBounds(topRight, bound: bound, shouldFloor: false)
            self.fitToBounds(bottomRight, bound: bound, shouldFloor: false)
            self.fitToBounds(bottomLeft, bound: bound, shouldFloor: false)
            
            var tiles = [Int64: TileIndex]()
            self.mergeTiles()
            var addedTilesCount = 0
            _addedTiles.removeAll(keepCapacity: true)
            
            var removedTilesCount = 0
            _removedTiles.removeAll(keepCapacity: true)
            
            for var y = topLeft._y; y < bottomLeft._y; ++y {
                for var x = topLeft._x; x < topRight._x; ++x {
                    var tile = TileIndex(x: x, y: y, z: Double(zoom))
                    tiles[tile._BId] = tile
                    if _unchangedTiles[tile._BId] == nil {
                        _addedTiles[tile._BId] = tile
                        ++addedTilesCount
                    }
                }
            }
            
//            println("topLeft:\(topLeft._y), bottomleft:\(bottomLeft._y)")
//            println("zoom:\(zoom)")
//            println("tiles : \(tiles.count)")
//            if (tiles.count > 0) {
//                println("toAff:\(tiles.count)")
//            }
//            if (_addedTiles.count > 0) {
//                println("added:\(_addedTiles.count)")
//            }
//            if (_unchangedTiles.count > 0) {
//                println("unchangedTiles:\(_unchangedTiles.count)")
//            }
            for key in _unchangedTiles {
                if (tiles[key.0] == nil) {
                    _removedTiles[key.0] = _unchangedTiles[key.0]
                    _unchangedTiles.removeValueForKey(key.0)
                    ++removedTilesCount
                }
            }
//            if (removedTilesCount > 0) {
//                println("removed:\(removedTilesCount)")
//            }
            if (removedTilesCount > 0) {
                throwEventRemoveTiles()
            }
            if (addedTilesCount > 0) {
                throwEventAddTiles()
            }
        }
    }
    
}

func recursiveBlockSubstitute<T, U>(block: (T, U, (T, U)->Int)->Int) -> (T, U)->Int {
    return { param in block(param.0, param.1, recursiveBlockSubstitute(block)) }
}

func recursiveBlockTile<T>(block: (T, T->Void)->Void) -> T->Void {
    return { param in block(param, recursiveBlockTile(block)) }
}
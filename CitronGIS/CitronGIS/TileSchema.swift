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
            _bounds[i] = bits
        }
    }
    func getZoomLevel(resolution:Double) -> Int
    {
        for (var i = 0; i < _resolutions.count; ++i)
        {
            var res = _resolutions[i];
            
            if (resolution > res && abs(resolution - res) < 0.0001)
            {
                return i > 0 ? i - 1 : 0
            }
        }
        return _resolutions.count - 1
    }
    
    func fitToBounds(point:GeometryPoint, bound:Double, shouldFloor:Bool)
    {
        if (shouldFloor)
        {
            point.x = floor(point.x)
            point.y = floor(point.y)
        }
        point.x = max(point.x, 0.0)
        point.y = max(point.y, 0.0)
        point.x = min(point.x, bound)
        point.x = min(point.y, bound)
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
  
        let tcenter = tileToWorld(TileIndex(x: x + 0.5, y: y + 0.5, z: tile._z, bid: tile._BId), resolution: resolution, size: size)
        let half = (size / 2) * resolution;
        let topLeft = Vector2(fromPosx: tcenter.x - half, andY: tcenter.y + half)
        let topRight = Vector2(fromPosx: tcenter.x + half, andY: tcenter.y + half)
        let bottomLeft = Vector2(fromPosx: tcenter.x - half, andY: tcenter.y + half)
        let bottomRight = Vector2(fromPosx: tcenter.x + half, andY: tcenter.y + half)
        
        return [topLeft, topRight, bottomLeft, bottomRight]
    }
    
    
    func computeTile(viewport:Viewport)
    {
        if (viewport.rotation == 0)
        {
            var zoom = self.getZoomLevel(viewport.resolution)
            _resolution = _resolutions[zoom]
            
            let size = Double(_resolution) / Double(viewport.resolution) * Double(_tileWidth)
            
            let bound = _bounds[zoom]
            let center = self.worldToTile(viewport.origin, resolution: viewport.resolution, size: size)
            center._x = floor(center._x)
            center._y = floor(center._y)
            
            let polyBox = [viewport.boundingBox.topLeft, viewport.boundingBox.topRight, viewport.boundingBox.botLeft, viewport.boundingBox.botRight]
            
            var cost = 0
            self.mergeTiles()
            
            var addedTilesCount = 0
            _addedTiles.removeAll(keepCapacity: true)
            
            var removedTilesCount = 0
            _removedTiles.removeAll(keepCapacity: true)
            
            var explored = Set<Int64>()
            var tiles = Set<Int64>()

            var rSearch:TileIndex->Void = recursiveBlockTile{tile, search in
                
                explored.insert(tile._BId)
                var tilePoly = self.tileToPoly(tile, resolution: self._resolution, size: size)

                
                if (IntersectionHelper.polygonContainsPolygon(polyBox, p2: tilePoly))
                {
                    if (tile._x >= 0 && tile._x < Double(bound) && tile._y >= 0 && tile._y < Double(bound))
                    {
                        tiles.insert(tile._BId)
                        if ((self._unchangedTiles[tile._BId]) != nil) {
                            self._addedTiles[tile._BId] = tile
                            ++addedTilesCount
                        }
                    }
                    var x = floor(tile._x)
                    var y = floor(tile._y)
                    
                    var nb = [TileIndex(x: x - 1, y: y, z: tile._z),
                        TileIndex(x: x + 1, y: y, z: tile._z),
                        TileIndex(x: x, y: y - 1, z: tile._z),
                        TileIndex(x: x, y: y + 1, z: tile._z)]
                    for idx in nb {
                        if explored.contains(idx._BId) == false {
                            search(idx)
                        }
                    }
                }
            }
            rSearch(center)
            
            for key in _unchangedTiles {
                if (tiles.contains(key.0) == false) {
                    _removedTiles[key.0] = _unchangedTiles[key.0]
                    ++removedTilesCount
                }
            }
            if (removedTilesCount > 0) {
                throwEventRemoveTiles()
            }
            if (addedTilesCount > 0) {
                throwEventAddTiles()
            }
        }
        else
        {
            //ROtation
        }
    }
    
}
func recursiveBlockTile<T>(block: (T, T->Void)->Void) -> T->Void {
    return { param in block(param, recursiveBlockTile(block)) }
}
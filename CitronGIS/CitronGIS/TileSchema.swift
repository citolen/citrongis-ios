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
    let _tileWidth:Int
    let _tileHeight:Int
    let _yAxisType:yAxisMode
    let _resolutions:[Double]
    let _originX:Double
    let _originY:Double
    var _bounds:[Int]
    let _resolution:Double
    var _unchangedTiles = [Int64: TileIndex]()
    var _removedTiles = [Int64: TileIndex]()
    var _addedTiles = [Int64: TileIndex]()
    
    init(tileWidth:Int, tileHeight:Int, yAxisType:yAxisMode, resolutions:[Double], originX:Double, originY:Double, bounds:[Int], resolution:Double)
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
    
    
    func tileToWorld(index:TileIndex, resolution:Double, size:Double, anchor:Double = 0.5) -> Vector2
    {
        fatalError("To Implement")
    }
    
    func worldToTile(world:Vector2, resolution:Double, size:Double)
    {
        
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
            
        }
        else
        {
            
        }
//        computeTiles = function (viewport) {
//            
//            'use strict';
//            
//            if (!C.Utils.Comparison.Equals(viewport._rotation, 0)) { // Compute tile with rotation
//                
//                var zoom = this.getZoomLevel(viewport._resolution);
//                this._resolution = this._resolutions[zoom];
//                
//                var size = this._resolution / viewport._resolution * this._tileWidth;
//                var bound = this._bounds[zoom];
//                
//                var center = this.worldToTile(viewport._origin, viewport._resolution, size);
//                center._x = Math.floor(center._x);
//                center._y = Math.floor(center._y);
//                
//                var polyBox = [
//                    [ viewport._bbox._topLeft.X, viewport._bbox._topLeft.Y ],
//                    [ viewport._bbox._topRight.X, viewport._bbox._topRight.Y ],
//                    [ viewport._bbox._bottomRight.X, viewport._bbox._bottomRight.Y ],
//                    [ viewport._bbox._bottomLeft.X, viewport._bbox._bottomLeft.Y ]
//                ];
//                
//                var self = this;
//                
//                var explored = {};
//                var cost = 0;
//                var tiles = {};
//                this._mergeTiles();
//                var addedTilesCount = 0;
//                this._addedTiles = {};  // reset added tiles
//                var removedTilesCount = 0;
//                this._removedTiles = {}; // reset removed tiles
//                
//                (function rSearch(tile) {
//                    
//                    explored[tile._BId] = 1;
//                    
//                    var tilePoly = self.tileToPoly(tile, viewport._resolution, size, viewport._rotation);
//                    
//                    if (C.Helpers.IntersectionHelper.polygonContainsPolygon(polyBox, tilePoly)) {
//                        // tile is in bbox
//                        
//                        if (tile._x >= 0 && tile._x < bound && tile._y >= 0 && tile._y < bound) {
//                            // this is a valid tile in view
//                            tiles[tile._BId] = tile;
//                            if (!(tile._BId in self._unchangedTiles)) { // this is a new tile
//                                self._addedTiles[tile._BId] = tile;
//                                ++addedTilesCount;
//                            }
//                        }
//                        var x = Math.floor(tile._x);
//                        var y = Math.floor(tile._y);
//                        
//                        var neighbours = [
//                            C.Layer.Tile.TileIndex.fromXYZ(x - 1, y     , tile._z),
//                            C.Layer.Tile.TileIndex.fromXYZ(x + 1, y     , tile._z),
//                            C.Layer.Tile.TileIndex.fromXYZ(x    , y - 1 , tile._z),
//                            C.Layer.Tile.TileIndex.fromXYZ(x    , y + 1 , tile._z)
//                        ];
//                        
//                        for (var i = 0; i < 4; ++i) {
//                            if (!(neighbours[i]._BId in explored))
//                            rSearch(neighbours[i]);
//                        }
//                    }
//                    })(center);
//                
//                /** Compute removed tiles **/
//                for (var key in this._unchangedTiles) {
//                    if (!(key in tiles)) { // this is a removed tile
//                        this._removedTiles[key] = this._unchangedTiles[key];
//                        delete this._unchangedTiles[key];
//                        ++removedTilesCount;
//                    }
//                }
//                
//                if (removedTilesCount > 0)
//                this.emit('removedTiles', this._removedTiles, viewport);
//                if (addedTilesCount > 0)
//                this.emit('addedTiles', this._addedTiles, viewport);
//                
//            } else {
//                
//                var zoom = this.getZoomLevel(viewport._resolution);
//                this._resolution = this._resolutions[zoom];
//                
//                var size = this._resolution / viewport._resolution * this._tileWidth;
//                
//                var topLeft = this.worldToTile(viewport._bbox._topLeft, viewport._resolution, size);
//                var topRight = this.worldToTile(viewport._bbox._topRight, viewport._resolution, size);
//                var bottomRight = this.worldToTile(viewport._bbox._bottomRight, viewport._resolution, size);
//                var bottomLeft = this.worldToTile(viewport._bbox._bottomLeft, viewport._resolution, size);
//                
//                var bound = this._bounds[zoom];
//                
//                this.fitToBounds(topLeft, bound, true);
//                this.fitToBounds(topRight, bound);
//                this.fitToBounds(bottomRight, bound);
//                this.fitToBounds(bottomLeft, bound);
//                
//                
//                
//                var tiles = {};
//                
//                this._mergeTiles();
//                var addedTilesCount = 0;
//                this._addedTiles = {};  // reset added tiles
//                var removedTilesCount = 0;
//                this._removedTiles = {}; // reset removed tiles
//                
//                for (var y = topLeft._y; y < bottomLeft._y; ++y) {
//                    for (var x = topLeft._x; x < topRight._x; ++x) {
//                        var tile = C.Layer.Tile.TileIndex.fromXYZ(x, y, zoom);
//                        tiles[tile._BId] = tile;
//                        if (!(tile._BId in this._unchangedTiles)) { // this is a new tile
//                            this._addedTiles[tile._BId] = tile;
//                            ++addedTilesCount;
//                        }
//                    }
//                }
//                
//                /** Compute removed tiles **/
//                for (var key in this._unchangedTiles) {
//                    if (!(key in tiles)) { // this is a removed tile
//                        this._removedTiles[key] = this._unchangedTiles[key];
//                        delete this._unchangedTiles[key];
//                        ++removedTilesCount;
//                    }
//                }
//                
//                if (removedTilesCount > 0)
//                this.emit('removedTiles', this._removedTiles, viewport);
//                if (addedTilesCount > 0)
//                this.emit('addedTiles', this._addedTiles, viewport);
//            }
//        };
    }
}
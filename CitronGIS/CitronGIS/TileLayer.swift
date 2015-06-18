//
//  TileLayer.swift
//  CitronGIS
//
//  Created by Charly DELAROCHE on 5/28/15.
//  Copyright (c) 2015 Charly DELAROCHE. All rights reserved.
//

import Foundation

class TileLayer : Layer
{
    let _tileSource:TileSource
    let _tileSchema:TileSchema
    var _tileInView = [Int64: (Image, TileIndex, Int)]() // feature + tileindex + level(Int)
    var _substitution = [Int64: [(Image, TileIndex, Int)]]() //[Int64: feature + tileindex + level]
    var _loading = Set<Int64>()
    var _cache = LRUCache<Int64, (Image, TileIndex, Int)>()
    
    init(tileSource:TileSource, tileSchema:TileSchema)
    {
        _tileSource = tileSource
        _tileSchema = tileSchema
        super.init()

    }
    
    override func onAdd() {
        _tileSchema.registerToEventAddTiles({(addedTiles:[Int64 : TileIndex]) -> Void in
            self.addedTile(addedTiles)
            }, key: "tileLayer")
        _tileSchema.registerToEventRemoveTiles({ (removedTiles:[Int64 : TileIndex]) -> Void in
//            self.removedTile(removedTiles)
            }, key: "tileLayer")
        VIEWPORT.registerToEventResolutionChange({() -> Void in
            self.resolutionChanged()
            }, key: "tileLayer")
        _tileSchema.throwEventRegister()
        
        VIEWPORT.registerToEventMove({ () -> Void in
            self._tileSchema.computeTile(VIEWPORT)
            
            }, key: "TileLayer")
    }
    
    override func onRemove() {
        _tileSchema.throwEventUnRegister()
        _tileSchema.unregisterToEventAddTiles("tileLayer")
        _tileSchema.unregisterToEventRemoveTiles("tileLayer")
        VIEWPORT.unregisterToEventResolutionChange("tileLayer")
        _tileInView.removeAll(keepCapacity: false)
        _substitution.removeAll(keepCapacity: false)
    }
    func getTilesSize() -> Double
    {
        return _tileSchema._resolution / VIEWPORT.resolution * _tileSchema._tileWidth
    }
    
    func resolutionChanged()
    {
        var rsize = self.getTilesSize()
        
        for key in _tileInView {
            let obj = key.1
            
            obj.0.setSize(CGSizeMake(CGFloat(rsize), CGFloat(rsize)))
            
            var location = self._tileSchema.tileToWorld(obj.1, resolution: VIEWPORT.resolution, size: rsize, anchor: 0.5)
            obj.0.setLocation(GeometryPoint(fromPosx: location.x, andY: location.y, andZ:0.0, andProj:ProjectionHelper.EPSG3857()))
        }
        
        for key in _substitution
        {
            var objs = key.1
            
            for var i = 0, j = objs.count; i < j; ++i {
                var obj = objs[i]
                var trsize = rsize
                if obj.2 == -1 {
                    trsize = rsize / Double(1 << obj.2)
                }
                obj.0.setSize(CGSizeMake(CGFloat(trsize), CGFloat(trsize)))
                let location = _tileSchema.tileToWorld(obj.1, resolution: VIEWPORT.resolution, size: trsize, anchor: 0.5)
                obj.0.setLocation(GeometryPoint(fromPosx: location.x, andY: location.y, andZ:0.0, andProj:ProjectionHelper.EPSG3857()))
            }
        }
    }
    
    func loadTile(tile:TileIndex, callback:(done:Bool)->())
    {
        let key = tile._BId

        _loading.remove(key)
        
        if (_tileSchema.isTileInView(tile) == false) {
            callback(done:true)
            return
        }
        
        var url = _tileSource.tileIndexToUrl(tile)
        var rsize = getTilesSize()
        var location = _tileSchema.tileToWorld(tile, resolution: VIEWPORT.resolution, size: rsize, anchor: 0.5)
        var pos = GeometryPoint(fromPosx: location.x, andY: location.y, andZ: 0.0, andProj: ProjectionHelper.EPSG3857())
        
        var feature = Image(url: url, success: { () -> () in
            if self._tileInView[key] == nil {
                callback(done: true)
                return
            }
            self._cache.add(key, value: self._tileInView[key]!)
            self.tileLoaded(key, animated:false)
            callback(done: true)
            
        }) { (op, err) -> () in
            if let v = self._tileInView[key] {
                
                self.removeFeature(v.0)
                
            }
            callback(done: true)
        }
        feature.setLocation(pos)
        feature.setSize(CGSizeMake(CGFloat(rsize), CGFloat(rsize)))
        self.addFeature(feature)
        
        _tileInView[key] = (feature, tile, -1)
    }
    func tileLoaded(key:Int64, animated:Bool)
    {
        if (animated == false)
        {
            return
        }
        
        //animate fade in
    }
    func addedTile(addedTiles:[Int64:TileIndex])
    {
        var rsize = self.getTilesSize()
        
        for key in addedTiles
        {
            var tile = key.1
            
            if let item = _cache.get(key.0)
            {
                _tileInView[key.0] = item
                item.0.setSize(CGSizeMake(CGFloat(rsize), CGFloat(rsize)))
                //item.0.rotation = -VIEWPORT.rotation
                var location = _tileSchema.tileToWorld(item.1, resolution: VIEWPORT.resolution, size: 0.0, anchor: 0.5)
                item.0.setLocation(GeometryPoint(fromPosx: location.x, andY: location.y, andZ: 0.0, andProj: ProjectionHelper.EPSG3857()))
                self.addFeature(item.0)
            }
            else if (_loading.contains(key.0) == false)
            {
                _loading.insert(key.0)
                self.loadTile(key.1, callback: { (done) -> () in
                    
                })
            }
            if (_substitution[key.0] == nil)
            {
                
                self.createSubstitute(key.1)
            }
        }
    }
    func createSubstitute(tile:TileIndex)
    {
        let trsize = self.getTilesSize()
        
        if (VIEWPORT.zoomDirection == ZoomDirection.Out) {
            var substituteTile = [(Int, TileIndex, (Image, TileIndex, Int))]()
            
            var recursiveBlock:(TileIndex, Int) -> (Int) = recursiveBlockSubstitute{tile, level, call in
                
                var children = tile.levelDown()
                
                var cover = 0

                
                for var i = 0; i < 4; ++i {
                    var child = children[i]
                    
                    if let childObj = self._cache.get(child._BId) {
                        substituteTile.append((level, child, childObj))
                        ++cover
                    } else if (Int(child._z) < self._tileSchema._resolutions.count && level < 3) {
                        if (call(tile, level + 1) != 4)
                        {
                            return 0
                        }
                    }
                    
                }
                
                return cover
            }
            let coverage = recursiveBlock(tile, 1)
            
            if (coverage == 4)
            {
                var tiles = [(Image, TileIndex, Int)]()
                for var i = 0, j = substituteTile.count; i < j; ++i {
                    var substitue = substituteTile[i]
                    
                    var img = substitue.2.0.copy()
                    var rsize = trsize / Double(1 << substitue.0)
                    var location = _tileSchema.tileToWorld(substitue.1, resolution: VIEWPORT.resolution, size: rsize, anchor: 0.5)
                    img.setLocation(GeometryPoint(fromPosx: location.x, andY: location.y, andZ: 0.0, andProj: ProjectionHelper.EPSG3857()))
                    img.setSize(CGSize(width: CGFloat(rsize), height: CGFloat(rsize)))
                    
                    tiles.append((img, substitue.1, substitue.0))
                    self.addFeature(img)
                    
                    //img.rotation = current rotation
                    
                    
                }
                _substitution[tile._BId] = tiles
                return
            }
        }
        
        
        var current = tile
        
        while current._z > 0 {
            var parent = current.levelUp()
            
            if let parentObj = _cache.get(parent._BId) {
                var pos = parent.positionInTiles(tile)
                
                
                break
            }
            current = parent
        }
    }
    
    func deleteSubstitute(key:Int64)
    {
        if let o = _substitution[key]  {
            for var i = 0, j = o.count; i < j; ++i {
                self.removeFeature(o[i].0)
            }
        }
    }

    func removedTile(removedTiles:[Int64:(Image, TileIndex, Int)])
    {
        for key in removedTiles {
            self.deleteSubstitute(key.0)
            if _tileInView[key.0] != nil {
                self.removeFeature(key.1.0)
            }
        }
    }
}


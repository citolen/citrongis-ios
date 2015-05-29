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
    var _tileInView = [Int64: TileIndex]()
    var _substitution = [TileIndex]()
    let _loading = [TileIndex]()
    
    init(tileSource:TileSource, tileSchema:TileSchema)
    {
        _tileSource = tileSource
        _tileSchema = tileSchema
        super.init()

    }
    
    override func onAdd() {
        _tileSchema.registerToEventAddTiles({(addedTiles:[Int64 : TileIndex]) -> Void in
            
            }, key: "tileLayer")
        _tileSchema.registerToEventRemoveTiles({ (removedTiles:[Int64 : TileIndex]) -> Void in
            
            }, key: "tileLayer")
        VIEWPORT.registerToEventResolutionChange({() -> Void in
            self.resolutionChanged()
            }, key: "tileLayer")
        _tileSchema.throwEventRegister()
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
            
        }
    }
    
    func loadTile()
    {
        
    }
    func tileLoaded()
    {
        
    }
    func addedTile()
    {
        
    }
    func createSubstitute()
    {
        
    }
    func deleteSubstitute()
    {
        
    }
    func removedTile()
    {
        
    }
}


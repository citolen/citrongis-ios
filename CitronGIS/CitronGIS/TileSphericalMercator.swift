//
//  TileSphericalMercator.swift
//  CitronGIS
//
//  Created by Charly DELAROCHE on 6/18/15.
//  Copyright (c) 2015 Charly DELAROCHE. All rights reserved.
//

import Foundation

class TileSphericalMercator : TileSchema {
    init()
    {
        super.init(extent:Extent(minX: -20037508.342789, andMinY: -20037508.342789, andMaxX: 20037508.342789, andMaxY: 20037508.342789), tileWidth: 256.0, tileHeight: 256.0, yAxisType: yAxisMode.Inverted, resolutions: [156543.033900000, 78271.516950000, 39135.758475000, 19567.879237500,
        9783.939618750, 4891.969809375, 2445.984904688, 1222.992452344,
        611.496226172, 305.748113086, 152.874056543, 76.437028271,
        38.218514136, 19.109257068, 9.554628534, 4.777314267,
        2.388657133, 1.194328567, 0.597164283, 0.29858214168548586, 0.14929107084274293, 0.07464553542137146], originX: -20037508.342789, originY: -20037508.342789, bounds: [], resolution: 0.5)
    }
    override func tileToWorld(index: TileIndex, resolution: Double, size: Double, anchor: Double) -> Vector2 {
        var worldX = _extent.minX + (index._x + anchor) * size * resolution
        var worldY = (index._y + anchor) * size * resolution//(tileIndex._y + anchor) * size * resolution;
        if (self._yAxisType == yAxisMode.Normal)
        {
            worldY = _extent.minY + worldY
        }
        else
        {
            worldY = _extent.maxY - worldY
        }
        return Vector2(fromPosx: worldX, andY: worldY)
    }
    
    override func worldToTile(world: Vector2, resolution: Double, size: Double) -> TileIndex {
        var tileX = (world.x - self._extent.minX) / resolution / size
        var tileY = world.y
        if (self._yAxisType == yAxisMode.Normal)
        {
            tileY = tileY - self._extent.minY
        }
        else
        {
            tileY = self._extent.maxY - tileY
        }
        tileY = tileY / resolution / size
        var tileZ = self.getZoomLevel(resolution)
        
        return TileIndex(x: tileX, y: tileY, z: Double(tileZ))
    }
    
}
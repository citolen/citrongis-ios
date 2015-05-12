//
//  SphericalMercator.swift
//  CitronGIS
//
//  Created by Charly DELAROCHE on 2/5/15.
//  Copyright (c) 2015 Charly DELAROCHE. All rights reserved.
//

import Foundation

class SphericalMercator : SchemaBase
{
    init()
    {
        super.init(name: "SphericalMercator", andCrs:ProjectionHelper.EPSG3857() , withOriginX: -20037508.342789, withOriginY: -20037508.342789, andBoudingBox: Extent(minX: -20037508.342789, andMinY: -20037508.342789, andMaxX: 20037508.342789, andMaxY: 20037508.342789))
    }
    override func translate(viewport: Viewport, tx: Double, ty: Double) {
        var mx = viewport.resolution * Double(tx)
        var my = viewport.resolution * Double(ty)
        
        viewport.origin.x += mx
        viewport.origin.y -= my
    }
    override func setTranslation(viewport: Viewport, tx: Double, ty: Double) {
        var mx = viewport.resolution * Double(tx)
        var my = viewport.resolution * Double(ty)
        
        viewport.origin.x = -mx
        viewport.origin.y = my
    }
    override func rotate(viewport: Viewport, angle: Double) {
        var pid = 2.0 * M_PI
        
        viewport.rotation = (viewport.rotation + (angle * M_PI / 180) + pid) % pid
    }
    
    override func update(viewport: Viewport) {
        var halfScreenMX = (viewport.resolution * Double(viewport.width)) / 2
        var halfScreenMY = (viewport.resolution * Double(viewport.height)) / 2
        
        if (abs(viewport.rotation) > 0.01)
        {
            var cosAngle = cos(viewport.rotation)
            var sinAngle = sin(viewport.rotation)
            
            var CosX = halfScreenMX * cosAngle;
            var SinX = halfScreenMX * sinAngle;
            var CosY = halfScreenMY * cosAngle;
            var SinY = halfScreenMY * sinAngle;
            
            viewport.boundingBox.botLeft.x = (-CosX) + SinY + viewport.origin.x;//*Signe simplification
            viewport.boundingBox.botLeft.y = (-SinX) - CosY + viewport.origin.y;//*Signe simplification
            viewport.boundingBox.topLeft.x = (-CosX) - SinY + viewport.origin.x;
            viewport.boundingBox.topLeft.y = (-SinX) + CosY + viewport.origin.y;
            
            viewport.boundingBox.topRight.x = CosX - SinY + viewport.origin.x;
            viewport.boundingBox.topRight.y = SinX + CosY + viewport.origin.y;
            
            viewport.boundingBox.botRight.x = CosX + SinY + viewport.origin.x;
            viewport.boundingBox.botRight.y = SinX - CosY + viewport.origin.y;
        } else {
            viewport.boundingBox.botLeft.x = viewport.origin.x - halfScreenMX;
            viewport.boundingBox.botLeft.y = viewport.origin.y - halfScreenMY;
            
            viewport.boundingBox.topLeft.x = viewport.origin.x - halfScreenMX;
            viewport.boundingBox.topLeft.y = viewport.origin.y + halfScreenMY;
            
            viewport.boundingBox.topRight.x = viewport.origin.x + halfScreenMX;
            viewport.boundingBox.topRight.y = viewport.origin.y + halfScreenMY;
            
            viewport.boundingBox.botRight.x = viewport.origin.x + halfScreenMX;
            viewport.boundingBox.botRight.y = viewport.origin.y - halfScreenMY;
        }
    }
    override func screenToWorld(viewport: Viewport, px: UInt, py: UInt) -> Vector2 {
        var dx:Double = -1.0 * (Double(viewport.width) / 2.0 - Double(px));
        var dy:Double = (Double(viewport.height) / 2.0 - Double(py));
        dx *= viewport.resolution; // to meter
        dy *= viewport.resolution; // to meter;
        
        if (abs(viewport.rotation) > 0.01) {
            var cosAngle = cos(viewport.rotation);
            var sinAngle = sin(viewport.rotation);
            
            var tmp = dx;
            dx = dx * cosAngle - dy * sinAngle;
            dy = tmp * sinAngle + dy * cosAngle;
        }
        
        dx += viewport.origin.x; // replace relative to origin
        dy += viewport.origin.y; // replace relative to origin
        return (Vector2(fromPosx: dx, andY: dy));
    }
    
    override func worldToScreen(viewport: Viewport, wx: Double, wy: Double) -> Vector2 {
        var dx = wx - viewport.origin.x;
        var dy = -(wy - viewport.origin.y);
        
        if (abs(viewport.rotation) > 0.01) {
            var cosAngle = cos(-viewport.rotation);
            var sinAngle = sin(-viewport.rotation);
            
            var tmp = dx;
            dx = dx * cosAngle - dy * sinAngle;
            dy = tmp * sinAngle + dy * cosAngle;
        }
        
        dx /= viewport.resolution; // to pixel
        dy /= viewport.resolution;
        dx += Double(viewport.width) / 2.0;
        dy += Double(viewport.height) / 2.0;
        return (Vector2(fromPosx: dx, andY: dy));
    }
}
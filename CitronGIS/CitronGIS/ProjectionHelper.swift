//
//  ProjectionHelper.swift
//  CitronGIS
//
//  Created by Charly DELAROCHE on 2/15/15.
//  Copyright (c) 2015 Charly DELAROCHE. All rights reserved.
//

import Foundation

class ProjectionHelper {
    
    class func WSG84() -> Projection
    {
        return Projection(fromName: "+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs")
    }
    class func EPSG3857() -> Projection
    {
        return Projection(fromName: "+proj=merc +a=6378137 +b=6378137 +lat_ts=0.0 +lon_0=0.0 +x_0=0.0 +y_0=0 +k=1.0 +units=m +nadgrids=@null +wktext  +no_defs")
    }
}
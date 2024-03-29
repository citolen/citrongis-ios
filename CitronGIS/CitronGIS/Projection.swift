//
//  Projection.swift
//  CitronGIS
//
//  Created by Charly DELAROCHE on 30/06/14.
//  Copyright (c) 2014 Charly DELAROCHE. All rights reserved.
//

import Foundation

class Projection
{
    var projection: projPJ
    var name = ""
    init(fromName name:NSString)
    {
        self.projection = pj_init_plus(name.UTF8String)
        self.name = name as String
    }
    init(fromProj proj:projPJ)
    {
        projection = proj
    }
    func isLatLong() -> Bool
    {
        return pj_is_latlong(projection) == 1 ? true : false
    }
    var description: String {
        return "\(pj_get_def(projection, 0))"
    }
    
}

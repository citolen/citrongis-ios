//
//  ResolutionHelper.swift
//  CitronGIS
//
//  Created by Charly DELAROCHE on 2/5/15.
//  Copyright (c) 2015 Charly DELAROCHE. All rights reserved.
//

import Foundation

class ResolutionHelper {
    
    class func resolutionReference() -> Double
    {
        return 156543.033900000
    }
    class func resolutionAtZoomLevel(level:Int) -> Double
    {        
        return resolutionReference() / pow(2, Double(level))
    }
}
//
//  TMSSource.swift
//  CitronGIS
//
//  Created by Charly DELAROCHE on 5/28/15.
//  Copyright (c) 2015 Charly DELAROCHE. All rights reserved.
//

import Foundation

class TMSSource : TileSource {
    private let _sourceUrl:String
    private let _sourceServer:[String]!
    private var _serverIdx = 0
    
    init(sourceUrl:String, sourceServer:[String]! = nil)
    {
        _sourceUrl = sourceUrl
        _sourceServer = sourceServer
    }
    override func tileIndexToUrl(index:TileIndex) -> String
    {
        var url = _sourceUrl.stringByReplacingOccurrencesOfString("{x}", withString: Int(index._x).description).stringByReplacingOccurrencesOfString("{y}", withString: Int(index._y).description).stringByReplacingOccurrencesOfString("{z}", withString: Int(index._z).description)
        
        if (_sourceServer != nil)
        {
            url = url.stringByReplacingOccurrencesOfString("{server}", withString: _sourceServer[_serverIdx])
            
            _serverIdx = (_serverIdx + 1) % _sourceServer.count
        }
        
        return url
    }
}
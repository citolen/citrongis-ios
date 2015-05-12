//
//  RequestManager.swift
//  CitronGIS
//
//  Created by Charly DELAROCHE on 4/17/15.
//  Copyright (c) 2015 Charly DELAROCHE. All rights reserved.
//

import Foundation

let REQUEST_MANAGER:RequestManager = RequestManager()
class RequestManager {
    let manager:AFHTTPRequestOperationManager
    
    init()
    {
        manager = AFHTTPRequestOperationManager()
    }
    func getImageWithUrl(url:String, success:(img:UIImage) -> (), error:(op:AFHTTPRequestOperation!, err:NSError!) -> (), percent:(pc:Double) -> ())
    {
        var request = manager.GET(url, parameters: nil, success: { (op:AFHTTPRequestOperation!, responseObject:AnyObject!) -> Void in
            
            success(img:responseObject as! UIImage)
            
            }) { (op:AFHTTPRequestOperation!, err:NSError!) -> Void in
                
                error(op: op, err: err)
                
        }
        request.responseSerializer = AFImageResponseSerializer()
        request.setDownloadProgressBlock { (a:UInt, b:Int64, c:Int64) -> Void in
            percent(pc: Double(b)/Double(c))
        }
    }
}

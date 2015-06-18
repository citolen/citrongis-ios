//
//  Image.swift
//  CitronGIS
//
//  Created by Charly DELAROCHE on 2/15/15.
//  Copyright (c) 2015 Charly DELAROCHE. All rights reserved.
//

import Foundation

class Image: Feature {
    var location:GeometryPoint = GeometryPoint()
    var node:CCSprite
    var size:CGSize = CGSizeZero
    
    override init() {
        node = CCSprite()
        node.anchorPoint = ccp(0.5, 0.5)
    }
    func copy() -> Image
    {
        var re = Image()
        re.setLocation(self.location)
        re.setSize(self.size)
        re.node = self.node.copy() as! CCSprite
        return re
    }
    init(name:String) {
        node = CCSprite(imageNamed: name)
        node.anchorPoint = ccp(0.5, 0.5)
    }
    init(url:String, success:() -> (), error:(op:AFHTTPRequestOperation!, err:NSError!) -> ())
    {
        node = CCSprite()
        node.anchorPoint = ccp(0.5, 0.5)
        super.init()
        setImageWithUrl(url, success: success, error: error)
    }
    
    func setImageWithUrl(url:String, success:() -> (), error:(op:AFHTTPRequestOperation!, err:NSError!) -> ())
    {
        REQUEST_MANAGER.getImageWithUrl(url, success: {[weak self] (img) -> () in
            
            if let strongSelf = self
            {

                var text = CCTexture(CGImage: img.CGImage, contentScale:CGFloat(2.0))
                
                
                
                strongSelf.node.spriteFrame = CCSpriteFrame(texture: text, rectInPixels: CGRectMake(0, 0, text.contentSizeInPixels.width, text.contentSizeInPixels.height), rotated: false, offset: ccp(0, 0), originalSize: text.contentSizeInPixels)
                strongSelf.setSize(strongSelf.size)


            }
            success()
        }, error: { (op, err) -> () in
            error(op: op, err: err)
        }) { (pc) -> () in
            
        }
    }
    func setImage(name:String)
    {
        let cache = CCSpriteFrameCache.sharedSpriteFrameCache()
        node.spriteFrame = cache.spriteFrameByName(name)
    }
    func setLocation(location:GeometryPoint)
    {
        self.location = location
        self.setDirty()
    }
    
    func setAnchorPoint(pt:CGPoint)
    {
        node.anchorPoint = pt
    }
    
    func setSize(size:CGSize)
    {
        self.node.scaleX = Float(size.width / self.node.contentSize.width)
        self.node.scaleY = Float(size.height / self.node.contentSize.height)
        self.size = size
        self.setDirty()
    }
    
    override func render(renderer:CocosRenderer) {
        node.position = renderer.getLocationOfPoint(location)
    }
    override func addToScene(renderer: CocosRenderer) {
        renderer.scene.addChild(node)
    }
}
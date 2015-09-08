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
    
    func createWithCrop(rect:CGRect) -> Image
    {
        var re = Image()
        re.setLocation(self.location)
        re.node = CCSprite()
        re.node.anchorPoint = ccp(0.5, 0.5)
        re.node.spriteFrame = CCSpriteFrame(texture:node.spriteFrame.texture, rectInPixels: rect, rotated: false, offset: CGPointZero, originalSize:CGSizeMake(CGFloat(rect.size.width), CGFloat(rect.size.height)))
        re.setSize(self.size)
        return re
    }
    func fadeOut(dur:NSTimeInterval, done:()->())
    {
        var fadeOut = CCActionFadeIn(duration: dur)
        var endBlock = CCActionCallBlock(block: done)
        var action = CCActionSequence(one: fadeOut, two: endBlock)
        action.tag = 1
        
        self.node.runAction(action)
    }
    func cancelActions()
    {
        if let action = node.getActionByTag(1) {
            action.stop()
        }
    }
    func fadeIn(dur:NSTimeInterval, done:()->())
    {
        var fadeIn = CCActionFadeIn(duration: dur)
        var endBlock = CCActionCallBlock(block: done)
        var action = CCActionSequence(one: fadeIn, two: endBlock)
        action.tag = 1
        self.node.runAction(action)
    }
    func setRotation(angle:Float)
    {
        node.rotation = (angle / Float(M_PI)) * 180.0
    }
    func copy() -> Image
    {
        var re = Image()
        re.setLocation(self.location)
        re.setSize(self.size)
        re.node = CCSprite()
        re.node.anchorPoint = ccp(0.5, 0.5)
        re.node.spriteFrame = self.node.spriteFrame
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
    
    override func removeFromScene() {
        self.node.removeFromParentAndCleanup(true)
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
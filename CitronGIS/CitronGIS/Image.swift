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
    
    
    override init() {
        node = CCSprite()
        node.anchorPoint = ccp(0.5, 0.5)
    }
    init(name:String) {
        node = CCSprite(imageNamed: name)
        node.anchorPoint = ccp(0.5, 0.5)
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
    func setSize(size:CGSize)
    {
        self.node.scaleX = Float(size.width / self.node.contentSize.width) / Float(CCDirector.sharedDirector().contentScaleFactor)
        self.node.scaleY = Float(size.height / self.node.contentSize.height) / Float(CCDirector.sharedDirector().contentScaleFactor)
        self.setDirty()
    }
    
    override func render(renderer:CocosRenderer) {
        node.position = renderer.getLocationOfPoint(location)
    }
    override func addToScene(renderer: CocosRenderer) {
        renderer.scene.addChild(node)
    }
}
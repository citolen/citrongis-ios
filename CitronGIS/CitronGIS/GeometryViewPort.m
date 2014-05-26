//
//  GeometryViewPort.m
//  CitronGIS
//
//  Created by Charly DELAROCHE on 13/05/14.
//  Copyright (c) 2014 Charly DELAROCHE. All rights reserved.
//

#import "GeometryViewPort.h"

@implementation SystemViewPort

+(SystemViewPort*)systemViewPortWithWidth: (int)width andHeight:(int)height andResolution:(double)resolution andBoundingBox:(BoundingBox*)bd
{
    SystemViewPort *svp;
    
    svp = [[SystemViewPort alloc] init];
    svp.width = width;
    svp.height = height;
    svp.resolution = resolution;
    svp.boundingBox = bd;
    return svp;
}

@end

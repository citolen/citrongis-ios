//
//  BoudingBox.m
//  CitronGIS
//
//  Created by Charly DELAROCHE on 13/05/14.
//  Copyright (c) 2014 Charly DELAROCHE. All rights reserved.
//

#import "BoundingBox.h"
#import "GeometryPoint.h"

@implementation BoundingBox

-(GeometryPoint*)center
{
    return nil;
}

-(BOOL)isPointInside:(GeometryPoint*)point
{
    return false;
}

-(BOOL)intersectBoundingBox:(BoundingBox*)other
{
    return false;
}

@end

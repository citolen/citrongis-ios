//
//  CoordinatesHelper.m
//  CitronGIS
//
//  Created by Charly DELAROCHE on 13/05/14.
//  Copyright (c) 2014 Charly DELAROCHE. All rights reserved.
//

#import "CoordinatesHelper.h"

@implementation CoordinatesHelper

+(GeometryPoint*)transformTo:(GeometryPoint*)point toProjPtr:(Projection*)proj
{
    double x = point.x;
    double y = point.y;
    double z = point.z;
    pj_transform(point.proj.proj, proj.proj, 1, 0, &x, &y, &z);
    
    GeometryPoint *re = [GeometryPoint GeometryPointWithX:x andY:y andZ:z andProjectionPtr:proj];
    
    return (re);
}

+(GeometryPoint*)transformTo:(GeometryPoint*)point toProj:(NSString*)proj
{
    Projection *newproj = [Projection projectionWithName:proj];
    
    double x = point.x;
    double y = point.y;
    double z = point.z;
    pj_transform(point.proj.proj, newproj.proj, 1, 0, &x, &y, &z);
    
    point.x = x;
    point.y = y;
    point.z = z;
    point.proj = newproj;
    
    GeometryPoint *re = [GeometryPoint GeometryPointWithX:x andY:y andZ:z andProjectionPtr:newproj];
    return re;
}

@end

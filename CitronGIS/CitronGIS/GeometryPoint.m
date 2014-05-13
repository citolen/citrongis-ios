//
//  GeometryPoint.m
//  CitronGIS
//
//  Created by Charly DELAROCHE on 12/05/14.
//  Copyright (c) 2014 Charly DELAROCHE. All rights reserved.
//

#import "GeometryPoint.h"

@implementation GeometryPoint

+ (GeometryPoint)GeometryPointWithX:(double)x andY:(double)y andZ:(double)z andProjection:(NSString *)projection
{
    GeometryPoint *re = [[GeometryPoint alloc] init];
    re.x = x;
    re.y = y;
    re.z = z;
    return re;
}

-(NSString*)description
{
    return ([NSString stringWithFormat:@”%f-%f-%f-%@”, _x, _y, _z, _projection->name]);
}


@end

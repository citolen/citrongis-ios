//
//  GeometryPoint.m
//  CitronGIS
//
//  Created by Charly DELAROCHE on 12/05/14.
//  Copyright (c) 2014 Charly DELAROCHE. All rights reserved.
//

#import "GeometryPoint.h"
#import "proj_api.h"

@implementation GeometryPoint
{
}

+ (GeometryPoint*)GeometryPointWithX:(double)x andY:(double)y andZ:(double)z andProjection:(NSString *)projection
{
    GeometryPoint *re = [[GeometryPoint alloc] init];
    re.x = x;
    re.y = y;
    re.z = z;
    
    re.proj = [Projection projectionWithName:projection];
    
    return re;
}

+ (GeometryPoint *)GeometryPointWithX:(double)x andY:(double)y andZ:(double)z andProjectionPtr:(Projection *)projection;
{
    GeometryPoint *re = [[GeometryPoint alloc] init];
    re.x = x;
    re.y = y;
    re.z = z;
    re.proj = projection;
    
    return re;
}

-(NSString*)description
{
    return [NSString stringWithFormat:@"%f-%f-%f-%@", _x, _y, _z, _proj];
}

#pragma mark - NSCoding Protocol

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeDouble:_x forKey:@"x"];
    [aCoder encodeDouble:_y forKey:@"y"];
    [aCoder encodeDouble:_z forKey:@"z"];
    [aCoder encodeObject:_proj.description forKey:@"proj"];
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    _x = [aDecoder decodeDoubleForKey:@"x"];
    _y = [aDecoder decodeDoubleForKey:@"y"];
    _z = [aDecoder decodeDoubleForKey:@"z"];
    
    NSString *projection = [aDecoder decodeObjectForKey:@"proj"];
    
    _proj = [Projection projectionWithName:projection];
    
    return self;
}

@end

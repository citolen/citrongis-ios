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

+ (GeometryPoint*)GeometryPointWithX:(double)x andY:(double)y andZ:(double)z andProjection:(NSString *)projection
{
    GeometryPoint *re = [[GeometryPoint alloc] init];
    re.x = x;
    re.y = y;
    re.z = z;
    
    if ((re.proj = pj_init_plus(projection.UTF8String)) == NULL)
    {
        @throw ([NSException exceptionWithName:@"crs_error" reason:@"Invalid projection" userInfo:nil]);
    }
    
    
    return re;
}

-(NSString*)description
{
    return [NSString stringWithFormat:@"%f-%f-%f-%s", _x, _y, _z, pj_get_def(_proj, 0)];
}

#pragma mark - NSCoding Protocol

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeDouble:_x forKey:@"x"];
    [aCoder encodeDouble:_y forKey:@"y"];
    [aCoder encodeDouble:_z forKey:@"z"];
    [aCoder encodeObject:[NSString stringWithUTF8String:pj_get_def(_proj, 0)] forKey:@"proj"];
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    _x = [aDecoder decodeDoubleForKey:@"x"];
    _y = [aDecoder decodeDoubleForKey:@"y"];
    _z = [aDecoder decodeDoubleForKey:@"z"];
    
    NSString *projection = [aDecoder decodeObjectForKey:@"proj"];
    
    if ((_proj = pj_init_plus(projection.UTF8String)) == NULL)
    {
        @throw ([NSException exceptionWithName:@"crs_error" reason:@"Invalid projection" userInfo:nil]);
    }
    
    return self;
}

@end

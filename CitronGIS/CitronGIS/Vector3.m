//
//  Vector3.m
//  CitronGIS
//
//  Created by emp on 20/05/14.
//  Copyright (c) 2014 Charly DELAROCHE. All rights reserved.
//

#import "Vector3.h"

@implementation GeometryVector3

+ (GeometryVector3 *)GeometryVectorWithX:(double)x andY:(double)y andZ:(double)z
{
    GeometryVector3 *re = [[GeometryVector3 alloc] init];
    re.x = x;
    re.y = y;
    re.z = z;
    return re;
}

- (BOOL)EqualsToVector:(GeometryVector3*)other
{
    if (other.x == _x && other.y == _y && other.z == _z)
        return TRUE;
    else
        return FALSE;
}

- (BOOL)EqualsBetween:(GeometryVector3*)va and:(GeometryVector3*)vb
{
    if (va.x == vb.x && va.y == vb.y && va.z == vb.z)
        return TRUE;
    else
        return FALSE;
    
}

- (double)distancewithVector:(GeometryVector3*)other
{
    double result;
    
    result = exp2((other.x - _x)) + exp2((other.y - _y)) + exp2((other.z - _z));
    result = sqrt(result);
    return result;
}

- (double)distanceBetween:(GeometryVector3*)va and:(GeometryVector3*)vb
{
    double result;
    
    result = exp2((va.x - vb.x)) + exp2((va.y - vb.y)) + exp2((va.z - vb.z));
    result = sqrt(result);
    return result;
}

- (double)dotProductwithVector:(GeometryVector3*)other
{
    double result;
    
    result = (other.x * _x) + (other.y * _y) + (other.z * _z);
    return result;
}

- (double)dotProductBetween:(GeometryVector3*)va and:(GeometryVector3*)vb
{
    double result;
    
    result = (va.x * vb.x) + (va.y * vb.y) + (va.z * vb.z);
    return result;
}

- (NSString*)toString
{
    return [NSString stringWithFormat:@"%f-%f-%f", _x, _y, _z];
}

@end

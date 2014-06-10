//
//  Vector2.m
//  CitronGIS
//
//  Created by emp on 20/05/14.
//  Copyright (c) 2014 Charly DELAROCHE. All rights reserved.
//

#import "Vector2.h"

@implementation GeometryVector2

+ (GeometryVector2 *)GeometryVectorWithX:(double)x andY:(double)y
{
    GeometryVector2 *re = [[GeometryVector2 alloc] init];
    re.x = x;
    re.y = y;
    return re;
}

- (BOOL)EqualsToVector:(GeometryVector2*)other
{
    if (other.x == _x && other.y == _y)
        return TRUE;
    else
        return FALSE;
}

- (BOOL)EqualsBetween:(GeometryVector2*)va and:(GeometryVector2*)vb
{
    if (va.x == vb.x && va.y == vb.y)
        return TRUE;
    else
        return FALSE;
    
}

- (double)distancewithVector:(GeometryVector2*)other
{
    double result;
    
    result = exp2((other.x - _x)) + exp2((other.y - _y));
    result = sqrt(result);
    return result;
}

- (double)distanceBetween:(GeometryVector2*)va and:(GeometryVector2*)vb
{
    double result;
    
    result = exp2((va.x - vb.x)) + exp2((va.y - vb.y));
    result = sqrt(result);
    return result;
}

- (double)dotProductwithVector:(GeometryVector2*)other
{
    double result;
    
    result = (other.x * _x) + (other.y * _y);
    return result;
}

- (double)dotProductBetween:(GeometryVector2*)va and:(GeometryVector2*)vb
{
    double result;
    
    result = (va.x * vb.x) + (va.y * vb.y);
    return result;
}

- (NSString*)toString
{
    return [NSString stringWithFormat:@"%f-%f", _x, _y];
}

@end
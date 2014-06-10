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

+ (BoundingBox *)BoundingBoxWithTopLeft:(GeometryVector2*)topLeft andTopRight:(GeometryVector2*)TopRight andBotLeft:(GeometryVector2*)botLeft andBotRight:(GeometryVector2*)botRight
{
    BoundingBox *bd = [BoundingBox alloc];
    bd.topLeft = topLeft;
    bd.topRight = TopRight;
    bd.botLeft = botLeft;
    bd.botRight = botRight;
    return bd;
}

-(GeometryVector2*)center
{
    return [GeometryVector2 GeometryVectorWithX:(_topLeft.x + _topRight.x + _botLeft.x + _botRight.x) / 4
                                           andY:(_topLeft.y + _topRight.y + _botLeft.y + _botRight.y) / 4];
}

-(BOOL)isPointInside:(GeometryPoint*)point
{
    double bax = _topRight.x - _topLeft.x;
    double bay = _topRight.y - _topLeft.y;
    double dax = _botRight.x - _topLeft.x;
    double day = _botRight.y - _topLeft.y;
    
    if ((point.x - _topLeft.x) * bax + (point.y - _topLeft.y) * bay < 0.0)
        return false;
    if ((point.x - _topRight.x) * bax + (point.y - _topRight.y) * bay > 0.0)
        return false;
    if ((point.x - _topLeft.x) * dax + (point.y - _topLeft.y) * day < 0.0)
        return false;
    if ((point.x - _botRight.x) * dax + (point.y - _botRight.y) * day > 0.0)
        return false;
    return true;
}

-(BOOL)isVectorInside:(GeometryVector2*)vector
{
    double bax = _topRight.x - _topLeft.x;
    double bay = _topRight.y - _topLeft.y;
    double dax = _botRight.x - _topLeft.x;
    double day = _botRight.y - _topLeft.y;
    
    if ((vector.x - _topLeft.x) * bax + (vector.y - _topLeft.y) * bay < 0.0)
        return false;
    if ((vector.x - _topRight.x) * bax + (vector.y - _topRight.y) * bay > 0.0)
        return false;
    if ((vector.x - _topLeft.x) * dax + (vector.y - _topLeft.y) * day < 0.0)
        return false;
    if ((vector.x - _botRight.x) * dax + (vector.y - _botRight.y) * day > 0.0)
        return false;
    return true;
}

-(BOOL)intersectBoundingBox:(BoundingBox*)other
{
    if ([other isVectorInside:_topLeft] == true ||
        [other isVectorInside:_topRight] == true ||
        [other isVectorInside:_botLeft] == true ||
        [other isVectorInside:_botRight] == true)
        return true;
    else
        return false;
}

-(BOOL)equals:(BoundingBox*)other
{
    if ([other.topLeft EqualsToVector:_topLeft] &&
        [other.topRight EqualsToVector:_topRight] &&
        [other.botLeft EqualsToVector:_botLeft] &&
        [other.botRight EqualsToVector:_botRight])
        return true;
    return false;
}

@end

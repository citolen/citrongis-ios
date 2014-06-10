//
//  BoudingBox.h
//  CitronGIS
//
//  Created by Charly DELAROCHE on 13/05/14.
//  Copyright (c) 2014 Charly DELAROCHE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GeometryPoint.h"
#import "Vector2.h"

@interface BoundingBox : NSObject

@property (nonatomic)   GeometryVector2   *topLeft;
@property (nonatomic)   GeometryVector2   *topRight;
@property (nonatomic)   GeometryVector2   *botLeft;
@property (nonatomic)   GeometryVector2   *botRight;

+ (BoundingBox *)BoundingBoxWithTopLeft:(GeometryVector2*)topLeft andTopRight:(GeometryVector2*)TopRight andBotLeft:(GeometryVector2*)botLeft andBotRight:(GeometryVector2*)botLeft;

-(GeometryVector2*)center;
-(BOOL)isPointInside:(GeometryPoint*)point;
-(BOOL)isVectorInside:(GeometryVector2*)vector;
-(BOOL)intersectBoundingBox:(BoundingBox*)other;
-(BOOL)equals:(BoundingBox*)other;

@end

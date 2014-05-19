//
//  BoudingBox.h
//  CitronGIS
//
//  Created by Charly DELAROCHE on 13/05/14.
//  Copyright (c) 2014 Charly DELAROCHE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GeometryPoint.h"

@interface BoundingBox : NSObject

@property (nonatomic)   GeometryPoint   *topLeft;
@property (nonatomic)   GeometryPoint   *topRight;
@property (nonatomic)   GeometryPoint   *botLeft;
@property (nonatomic)   GeometryPoint   *botRight;

-(GeometryPoint*)center;

-(BOOL)isPointInside:(GeometryPoint*)point;

-(BOOL)intersectBoundingBox:(BoundingBox*)other;


@end

//
//  GeometryPoint.h
//  CitronGIS
//
//  Created by Charly DELAROCHE on 12/05/14.
//  Copyright (c) 2014 Charly DELAROCHE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Projection.h"

@interface GeometryPoint : NSObject <NSCoding>

@property (nonatomic)double x;
@property (nonatomic)double y;
@property (nonatomic)double z;

@property (nonatomic)Projection *proj;


+ (GeometryPoint *)GeometryPointWithX:(double)x andY:(double)y andZ:(double)z andProjection:(NSString *)projection;
+ (GeometryPoint *)GeometryPointWithX:(double)x andY:(double)y andZ:(double)z andProjectionPtr:(Projection *)projection;

@end

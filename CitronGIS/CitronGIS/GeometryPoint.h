//
//  GeometryPoint.h
//  CitronGIS
//
//  Created by Charly DELAROCHE on 12/05/14.
//  Copyright (c) 2014 Charly DELAROCHE. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "proj_api.h"

@interface GeometryPoint : NSObject <NSCoding>

@property (nonatomic)double x;
@property (nonatomic)double y;
@property (nonatomic)double z;

@property (nonatomic)projPJ *projection;


+ (GeometryPoint *)GeometryPointWithX:(double)x andY:(double)y andZ:(double)z andProjection:(NSString *)projection;


@end

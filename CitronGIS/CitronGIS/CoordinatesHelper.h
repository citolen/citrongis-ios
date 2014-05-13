//
//  CoordinatesHelper.h
//  CitronGIS
//
//  Created by Charly DELAROCHE on 13/05/14.
//  Copyright (c) 2014 Charly DELAROCHE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "proj_api.h"
#import "GeometryPoint.h"
#import "Projection.h"

@interface CoordinatesHelper : NSObject

+(void)transformTo:(GeometryPoint*)point toProjPtr:(Projection*)proj;
+(void)transformTo:(GeometryPoint*)point toProj:(NSString*)proj;

@end

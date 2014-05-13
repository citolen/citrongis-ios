//
//  Projection.h
//  CitronGIS
//
//  Created by Charly DELAROCHE on 13/05/14.
//  Copyright (c) 2014 Charly DELAROCHE. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "proj_api.h"

@interface Projection : NSObject

+(Projection*)projectionWithName:(NSString*)name;
+(Projection*)projectionWithProj:(projPJ*)proj;

-(NSString*)description;

@property (nonatomic)   projPJ *proj;

@end

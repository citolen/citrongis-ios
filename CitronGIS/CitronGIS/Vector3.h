//
//  Vector3.h
//  CitronGIS
//
//  Created by emp on 20/05/14.
//  Copyright (c) 2014 Charly DELAROCHE. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GeometryVector3 : NSObject

@property (nonatomic)   double   x;
@property (nonatomic)   double   y;
@property (nonatomic)   double   z;

+ (GeometryVector3 *)GeometryVectorWithX:(double)x andY:(double)y andZ:(double)z;
- (BOOL)EqualsToVector:(GeometryVector3*)other;
- (BOOL)EqualsBetween:(GeometryVector3*)va and:(GeometryVector3*)vb;
- (double)distancewithVector:(GeometryVector3*)other;
- (double)distanceBetween:(GeometryVector3*)va and:(GeometryVector3*)vb;
- (double)dotProductwithVector:(GeometryVector3*)other;
- (double)dotProductBetween:(GeometryVector3*)va and:(GeometryVector3*)vb;
- (NSString*)toString;

@end

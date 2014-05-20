//
//  Vector2.h
//  CitronGIS
//
//  Created by emp on 20/05/14.
//  Copyright (c) 2014 Charly DELAROCHE. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GeometryVector2 : NSObject

@property (nonatomic)   double   x;
@property (nonatomic)   double   y;

+ (GeometryVector2 *)GeometryVectorWithX:(double)x andY:(double)y;
- (BOOL)EqualsToVector:(GeometryVector2*)other;
- (BOOL)EqualsBetween:(GeometryVector2*)va and:(GeometryVector2*)vb;
- (double)distancewithVector:(GeometryVector2*)other;
- (double)distanceBetween:(GeometryVector2*)va and:(GeometryVector2*)vb;
- (double)dotProductwithVector:(GeometryVector2*)other;
- (double)dotProductBetween:(GeometryVector2*)va and:(GeometryVector2*)vb;
- (NSString*)toString;

@end

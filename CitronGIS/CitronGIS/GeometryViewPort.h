//
//  GeometryViewPort.h
//  CitronGIS
//
//  Created by Charly DELAROCHE on 13/05/14.
//  Copyright (c) 2014 Charly DELAROCHE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BoundingBox.h"

@interface SystemViewPort : NSObject

+(SystemViewPort*)systemViewPortWithWidth: (int)width andHeight:(int)height andResolution:(double)resolution andBoundingBox:(BoundingBox*)bd;

@property (nonatomic)   int width;
@property (nonatomic)   int height;
@property (nonatomic)   double resolution;
@property (nonatomic)   BoundingBox *boundingBox;


@end

//
//  TapDetectingWindow.m
//  CitronGIS
//
//  Created by Charly DELAROCHE on 1/14/15.
//  Copyright (c) 2015 Charly DELAROCHE. All rights reserved.
//

#import "TapDetectingWindow.h"

@implementation TapDetectingWindow
{
}


-(void)sendEvent:(UIEvent *)event
{
    _lastEvent = event;
    [super sendEvent:event];
}

@end

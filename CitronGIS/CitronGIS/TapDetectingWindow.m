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
//    NSMutableArray *_savedEvent;
}

//-(instancetype)init
//{
//    if (!(self = [super init]))
//    {
//    }
//    return self;
//}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


-(void)sendEvent:(UIEvent *)event
{
    _lastEvent = event;
    [super sendEvent:event];
}

@end

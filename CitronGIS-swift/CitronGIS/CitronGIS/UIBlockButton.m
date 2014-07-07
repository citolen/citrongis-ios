//
//  UIBlockButton.m
//  CooviaAdmin
//
//  Created by Charly DELAROCHE on 19/02/14.
//  Copyright (c) 2014 Charly DELAROCHE. All rights reserved.
//

#import "UIBlockButton.h"

@implementation UIBlockButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void) handleControlEvent:(UIControlEvents)event
                 withBlock:(ActionBlock) action
{
    _actionBlock = action;
    [self addTarget:self action:@selector(callActionBlock:) forControlEvents:event];
}

-(void) callActionBlock:(id)sender{
    _actionBlock();
}

-(void)trigger
{
    _actionBlock();
}

@end

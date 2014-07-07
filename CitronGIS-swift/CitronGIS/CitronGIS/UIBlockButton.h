//
//  UIBlockButton.h
//  CooviaAdmin
//
//  Created by Charly DELAROCHE on 19/02/14.
//  Copyright (c) 2014 Charly DELAROCHE. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ActionBlock)();

@interface UIBlockButton : UIButton {
    ActionBlock _actionBlock;
}

-(void) handleControlEvent:(UIControlEvents)event
                 withBlock:(ActionBlock) action;

-(void)trigger;

@end
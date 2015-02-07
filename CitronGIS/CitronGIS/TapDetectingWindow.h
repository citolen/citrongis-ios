//
//  TapDetectingWindow.h
//  CitronGIS
//
//  Created by Charly DELAROCHE on 1/14/15.
//  Copyright (c) 2015 Charly DELAROCHE. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TapDetectingWindow : UIWindow

@property (nonatomic, strong)       UIEvent        *lastEvent;
@end

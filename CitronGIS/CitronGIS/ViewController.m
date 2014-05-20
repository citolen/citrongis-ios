//
//  ViewController.m
//  CitronGIS
//
//  Created by Charly DELAROCHE on 10/05/14.
//  Copyright (c) 2014 Charly DELAROCHE. All rights reserved.
//

#import "ViewController.h"
#import "SVProgressHUD.h"
#import "StyledPullableView.h"

@interface ViewController ()
{
    StyledPullableView *pullRightView;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    pullRightView = [[StyledPullableView alloc] initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height)];
    pullRightView.backgroundColor = [UIColor clearColor];
    pullRightView.openedCenter = CGPointMake(120, pullRightView.frame.size.height / 2.0);
    pullRightView.closedCenter = CGPointMake(-139, pullRightView.frame.size.height / 2.0);
    pullRightView.center = pullRightView.closedCenter;
    pullRightView.animate = YES;
    
    pullRightView.handleView.backgroundColor = [UIColor clearColor];
    pullRightView.handleView.frame = CGRectMake(0, 0, 320, 564);
    
    [self.view addSubview:pullRightView];

	// Do any additional setup after loading the view, typically from a nib.
}

-(void)pullableView:(PullableView *)pView didChangeState:(BOOL)opened
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    
}

@end

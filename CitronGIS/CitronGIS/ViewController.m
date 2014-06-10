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
#import "UIBlockButton.h"
#import "SKBounceAnimation.h"

@interface ViewController ()
{
    StyledPullableView *pullRightView;
    NSArray            *_btns;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)
                                                         forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    
    pullRightView = [[StyledPullableView alloc] initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height)];
    pullRightView.backgroundColor = [UIColor clearColor];
    pullRightView.openedCenter = CGPointMake(160, pullRightView.frame.size.height / 2.0);
    pullRightView.closedCenter = CGPointMake(-126, pullRightView.frame.size.height / 2.0);
    pullRightView.center = pullRightView.closedCenter;
    pullRightView.animate = YES;
    pullRightView.delegate = self;
    
    pullRightView.handleView.backgroundColor = [UIColor clearColor];
    pullRightView.handleView.frame = CGRectMake(0, 0, 320, 564);
    
    [self.view addSubview:pullRightView];

    __weak id weakself = self;
    [pullRightView setCallBack:^(float percent)
    {
        percent *= 0.55;
        float pc = 1 - percent;
        
        for (UIBlockButton *v in [weakself btns])
        {
            [v setImageEdgeInsets:UIEdgeInsetsMake(pc * 70, pc * 70, pc * 70, pc * 70)];
        }
    }];
    
    UIBlockButton *my_account = [[UIBlockButton alloc] initWithFrame:CGRectMake(0, 0, 140, 140)];
    my_account.backgroundColor = [UIColor colorWithRed:103.0/256.0 green:187.0/256.0 blue:156.0/256.0 alpha:1.0];
    [pullRightView addSubview:my_account];
    [my_account handleControlEvent:UIControlEventTouchUpInside withBlock:^{
        UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"signIn"];
        [self.navigationController pushViewController:vc animated:true];
    }];
    [my_account setImage:[UIImage imageNamed:@"my_account.png"] forState:UIControlStateNormal];
    
    UIBlockButton *shop = [[UIBlockButton alloc] initWithFrame:CGRectMake(140, 0, 140, 140)];
    shop.backgroundColor = [UIColor colorWithRed:112.0/256.0 green:204.0/256.0 blue:112.0/256.0 alpha:1.0];
    [pullRightView addSubview:shop];
    [shop setImage:[UIImage imageNamed:@"shop.png"] forState:UIControlStateNormal];
    
    UIBlockButton *search = [[UIBlockButton alloc] initWithFrame:CGRectMake(0, 140, 140, 140)];
    search.backgroundColor = [UIColor colorWithRed:241.0/256.0 green:196.0/256.0 blue:7.0/256.0 alpha:1.0];
    [pullRightView addSubview:search];
    [search setImage:[UIImage imageNamed:@"search.png"] forState:UIControlStateNormal];
    
    UIBlockButton *settings = [[UIBlockButton alloc] initWithFrame:CGRectMake(140, 140, 140, 140)];
    settings.backgroundColor = [UIColor colorWithRed:229.0/256.0 green:126.0/256.0 blue:34.0/256.0 alpha:1.0];
    [pullRightView addSubview:settings];
    [settings setImage:[UIImage imageNamed:@"settings.png"] forState:UIControlStateNormal];
    
    UIBlockButton *menu = [[UIBlockButton alloc] initWithFrame:CGRectMake(0, 280, 140, 140)];
    menu.backgroundColor = [UIColor colorWithRed:83.0/256.0 green:152.0/256.0 blue:118.0/256.0 alpha:1.0];
        [pullRightView addSubview:menu];
    [menu setImage:[UIImage imageNamed:@"menu.png"] forState:UIControlStateNormal];
    
    UIBlockButton *last = [[UIBlockButton alloc] initWithFrame:CGRectMake(140, 280, 140, 140)];
    last.backgroundColor = [UIColor colorWithRed:155.0/256.0 green:89.0/256.0 blue:182.0/256.0 alpha:1.0];
    [pullRightView addSubview:last];
    
    _btns = @[my_account, shop, search, settings, menu, last];
	// Do any additional setup after loading the view, typically from a nib.
}

-(void)pullableView:(PullableView *)pView didChangeState:(BOOL)opened
{
    if (opened)
    {
        for (UIBlockButton *v in _btns)
        {
            NSString *keyPath = @"transform";
            CATransform3D transform = v.imageView.layer.transform;
            id finalValue = [NSValue valueWithCATransform3D:
                             CATransform3DScale(transform, 1.25, 1.25, 1.25)
                             ];
            
            SKBounceAnimation *bounceAnimation = [SKBounceAnimation animationWithKeyPath:keyPath];
            bounceAnimation.fromValue = [NSValue valueWithCATransform3D:transform];
            bounceAnimation.toValue = finalValue;
            bounceAnimation.duration = 0.3f;
            bounceAnimation.numberOfBounces = 4;
            bounceAnimation.shouldOvershoot = YES;
            
            [v.imageView.layer addAnimation:bounceAnimation forKey:@"someKey"];
            
            
            transform = v.imageView.layer.transform;
            id finalValue2 = [NSValue valueWithCATransform3D:
                              CATransform3DScale(transform, 1.0, 1.0, 1.0)
                              ];
            
            bounceAnimation = [SKBounceAnimation animationWithKeyPath:keyPath];
            bounceAnimation.fromValue = finalValue;
            bounceAnimation.toValue = finalValue2;
            bounceAnimation.duration = 0.3f;
            bounceAnimation.numberOfBounces = 4;
            bounceAnimation.shouldOvershoot = YES;
            
            [v.imageView.layer addAnimation:bounceAnimation forKey:@"someKey2"];
        }        
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:true];
}

- (void)viewDidAppear:(BOOL)animated
{
}

-(NSArray*)btns
{
    return _btns;
}

-(void)pullableView:(PullableView *)pView willChangeState:(BOOL)opened withDuration:(float)duration
{
    if (opened)
    {
        [UIView animateWithDuration:duration animations:^{
            for (UIBlockButton *v in _btns)
            {
                [v setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
            }
        }];
    }
    else
    {
        [UIView animateWithDuration:duration animations:^{
            for (UIBlockButton *v in _btns)
            {
                [v setImageEdgeInsets:UIEdgeInsetsMake(70, 70, 70, 70)];
            }
        }];
    }
}

@end

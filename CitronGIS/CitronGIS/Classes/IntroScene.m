//
//  IntroScene.m
//  CitronGIS
//
//  Created by Charly DELAROCHE on 11/11/14.
//  Copyright Charly DELAROCHE 2014. All rights reserved.
//
// -----------------------------------------------------------------------

// Import the interfaces
#import "IntroScene.h"
#import "HelloWorldScene.h"

// -----------------------------------------------------------------------
#pragma mark - IntroScene
// -----------------------------------------------------------------------

@implementation IntroScene
{
    CCNodeColor *background;
}

// -----------------------------------------------------------------------
#pragma mark - Create & Destroy
// -----------------------------------------------------------------------

+ (IntroScene *)scene
{
	return [[self alloc] init];
}

// -----------------------------------------------------------------------

- (id)init
{
    self = [super init];
    if (!self) return(nil);
    
    
    // Create a colored background (Dark Grey)
    background = [CCNodeColor nodeWithColor:[CCColor colorWithRed:1.0f green:1.0f blue:1.0f alpha:1.0f]];
    [self addChild:background];
//
//    // Hello world
//    CCLabelTTF *label = [CCLabelTTF labelWithString:@"Hello World" fontName:@"Chalkduster" fontSize:36.0f];
//    label.positionType = CCPositionTypeNormalized;
//    label.color = [CCColor redColor];
//    label.position = ccp(0.5f, 0.5f); // Middle of screen
//    [self addChild:label];
//    
    // Helloworld scene button
//    CCButton *helloWorldButton = [CCButton buttonWithTitle:@"[ Start ]" fontName:@"Verdana-Bold" fontSize:18.0f];
////    helloWorldButton.positionType = CCPositionTypeNormalized;
//    helloWorldButton.position = ccp(0, 736);
//    helloWorldButton.anchorPoint = ccp(0.5, 0.5);
////    helloWorldButton.position = ccp(0.6f, 0.70f);
//    [helloWorldButton setTarget:self selector:@selector(onSpinningClicked:)];
//    [self addChild:helloWorldButton];

//    CCDrawNode *test = [[CCDrawNode alloc] init];
    
    
//    CGPoint *test2 = (CGPoint*)malloc(4 * sizeof(CGPoint));
//    test2[0] = CGPointMake(207.0,368.0);
//    test2[1] = CGPointMake(207.0,399.083735623851);
//    test2[2] = CGPointMake(207.0,382.520166566081);
//    test2[3] = CGPointMake(207.0, 0);
//    
//    [test drawPolyWithVerts:test2 count:4 fillColor:[CCColor blueColor] borderWidth:1 borderColor:[CCColor blackColor]];
//    [self addChild:test];
    
	return self;
}


-(void)update:(CCTime)delta
{
    if (background.parent == nil)
    {
        [self addChild:background];
    }
//    NSLog(@"update");
}

-(void)onEnter
{
    [super onEnter];

}

-(void)addChild:(CCNode *)node
{
    [super addChild:node];
}
// -----------------------------------------------------------------------
#pragma mark - Button Callbacks
// -----------------------------------------------------------------------

- (void)onSpinningClicked:(id)sender
{
    // start spinning scene with transition
    [[CCDirector sharedDirector] replaceScene:[HelloWorldScene scene]
                               withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionLeft duration:1.0f]];
}

// -----------------------------------------------------------------------
@end

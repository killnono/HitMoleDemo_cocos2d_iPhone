//
//  LoadScene.m
//  LoadingSim
//
//  Created by Nono on 12-7-17.
//  Copyright (c) 2012年 NonoWithLilith. All rights reserved.
//

#import "LoadScene.h"
#import "HelloWorldLayer.h"
@implementation LoadScene



-(id) initWithTargetScene:(TargetScenes)targetScene
{
	if ((self = [super init]))
	{
        tag = targetScene;
		CCLabelTTF  *label = [CCLabelTTF labelWithString:@"Loading......" fontName:@"Verdana-Bold" fontSize:60];
		CGSize size = [[CCDirector sharedDirector] winSize];
		label.position = CGPointMake(size.width / 2, size.height / 2);
        [self addChild:label];
		// Must wait one frame before loading the target scene!
		// Two reasons: first, it would crash if not. Second, the Loading label wouldn't be displayed.
		[self schedule:@selector(update:) interval:3];
	}
	return self;
}
	
+(id)sceneWithTargetScene:(TargetScenes)targetScene
{
   
	CCLOG(@"===========================================");
	CCLOG(@"%@: %@", NSStringFromSelector(_cmd), self);
    
	// This creates an autorelease object of self (the current class: LoadingScene)
	return [[[self alloc] initWithTargetScene:targetScene] autorelease];
	
	// Note: this does the exact same, it only replaced self with LoadingScene. The above is much more common.
	//return [[[LoadingScene alloc] initWithTargetScene:targetScene] autorelease];

	return self;
}


-(void)onEnter
{
    /*init后会调用;
        若是加了CCTransitionScene后，在过渡场景开始后调用
     */
    [super onEnter];
    CCLOG(@"执行了~~onEnter");
}

- (void)onEnterTransitionDidFinish
{
    /*onEnter以后将会调用此方法
     若使用CCTransitionScene,将会在过渡效果结束以后调用此方法
     */
    [super onEnterTransitionDidFinish];
    CCLOG(@"执行了~~onEnterTransitionDidFinish");
    
}

- (void)onExitTransitionDidStart
{
    CCLOG(@"执行了~~onExitTransitionDidStart");
    [super onExitTransitionDidStart];
}

- (void)onExit
{
    // 节点调用dealloc方法之前将会调用此方法
    //如果使用了CCTransitionScene,将会在过渡效果结束以后调用此方法
    CCLOG(@"执行了~~onExit");
    [super onExit];
}



-(void) update:(ccTime)delta
{
	// It's not strictly necessary, as we're changing the scene anyway. But just to be safe.
	[self unscheduleAllSelectors];
//	CCSlideInBTransition* transition = [CCSlideInBTransition transitionWithDuration:3 scene:[OtherScene scene]];
//	[[CCDirector sharedDirector] replaceScene:transition];
    CCTransitionSlideInT *ta = [CCTransitionSlideInT transitionWithDuration:1.5 scene:[HelloWorldLayer scene]];
    
    [[CCDirector sharedDirector] replaceScene:ta];
	// Decide which scene to load based on the TargetScenes enum.
	// You could also use TargetScene to load the same with using a variety of transitions.
//	switch (targetScene_)
//	{
//		case TargetSceneFirstScene:
//			[[CCDirector sharedDirector] replaceScene:[FirstScene scene]];
//			break;
//		case TargetSceneOtherScene:
//			[[CCDirector sharedDirector] replaceScene:[OtherScene scene]];
//			break;
//		case TargetSceneMultiLayerScene:
//            // Important note: if you create new local variables within a case block, it must be put in brackets.
//            // Otherwise you'll receive a compilation error "Expected expression before ..."
//		{
//			CCFadeTransition* transition = [CCFadeTransition transitionWithDuration:3 scene:[MultiLayerScene scene] withColor:ccWHITE];
//			[[CCDirector sharedDirector] replaceScene:transition];
//			break;
//		}
//		case TargetSceneParallaxScene:
//			[[CCDirector sharedDirector] replaceScene:[ParallaxScene scene]];
//			break;
//			
//		default:
//			// Always warn if an unspecified enum value was used. It's a reminder for yourself to update the switch
//			// whenever you add more enum values.
//			NSAssert2(nil, @"%@: unsupported TargetScene %i", NSStringFromSelector(_cmd), targetScene_);
//			break;
//	}
	
	// Tip: example usage of the INVALID and MAX enum values to iterate over all enum values
//	for (TargetScenes i = TargetSceneINVALID + 1; i < TargetSceneMAX; i++)
//	{
//	}
}



@end

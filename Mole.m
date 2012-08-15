//
//  Mole.m
//  LoadingSim
//
//  Created by Nono on 12-7-19.
//  Copyright (c) 2012年 NonoWithLilith. All rights reserved.
//

#import "Mole.h"
#import "CCAnimation.h"
#import "CCAnimationHelper.h"

@implementation Mole
@synthesize active,isLaguh;

- (void)dealloc
{
    [super dealloc];
}
+(id)mole
{
    return [[[self alloc] initWithMoleImage]autorelease];
}
-(id) initWithMoleImage
{
	// Loading the Ship's sprite using a sprite frame name (eg the filename)
	if ((self = [super initWithSpriteFrameName:@"mole_1.png"]))
	{
        //可以做一些初始化
        active = NO;
        isLaguh = NO;
    }
	return self;
}

-(void)setLaguhingU:(id)sender
{
    self.isLaguh = YES;
}

-(void)quitLaguhingU:(id)sender
{
    self.isLaguh = NO;
}

-(void)popMole
{
    [self unschedule:@selector(popMole)];
    [self stopAllActions];
    
    CCAnimation* anim = [CCAnimation animationWithFrame:@"mole_laugh" frameCount:3 delay:0.2f];
    CCAnimate* laughAn = [CCAnimate actionWithAnimation:anim];  
 
    CCCallFunc *setLaugh = [CCCallFunc actionWithTarget:self selector:@selector(setLaguhingU:)];
    CCCallFunc *quitLaugh = [CCCallFunc actionWithTarget:self selector:@selector(quitLaguhingU:)];

    CCMoveBy *up = [CCMoveBy actionWithDuration:0.5 position:ccp(0, self.contentSize.height)];
    CCEaseInOut *es = [CCEaseInOut actionWithAction:up rate:5.0];
    id moveDown = [es reverse];
    
   
    CCCallFunc *endCall = [CCCallFunc actionWithTarget:self selector:@selector(keepQuiet)];
    [self runAction:[CCSequence actions:es, setLaugh,laughAn, quitLaugh,moveDown, endCall, nil]]; 
    
}
-(void)moleHide
{
    //[self unschedule:@selector(moleHide:)];
    CGPoint old = self.position;
    self.position =CGPointMake(old.x, 85); 
    self.active = NO;
    
}

//敲打到鼹鼠
- (void)thumpMole
{

    [self stopAllActions];
   // [self keepQuiet];
    self.isLaguh = NO;
    CCAnimation* anim = [CCAnimation animationWithFrame:@"mole_thump" frameCount:3 delay:0.2f];
    CCAnimate* thump = [CCAnimate actionWithAnimation:anim];  
    //id thumAc = [CCRepeatForever actionWithAction:thumps];
    
    CCAction * hide = [CCCallFunc actionWithTarget:self selector:@selector(moleHide)];
    [self runAction:[CCSequence actions:thump,hide, nil]];
    
   
}

//保持在地下状态
-(void)keepQuiet
{
    self.active = NO;
    self.isLaguh = NO;
   // [self stopAllActions];
}

@end
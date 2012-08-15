//
//  HelloWorldLayer.m
//  LoadingSim
//
//  Created by Nono on 12-7-17.
//  Copyright NonoWithLilith 2012年. All rights reserved.
//


// Import the interfaces
#import "HelloWorldLayer.h"
#import "Mole.h"

// Needed to obtain the Navigation Controller
#import "AppDelegate.h"

#pragma mark - HelloWorldLayer

// HelloWorldLayer implementation
@implementation HelloWorldLayer
// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
	CCScene *scene = [CCScene node];
	HelloWorldLayer *layer = [HelloWorldLayer node];
    layer.isTouchEnabled = YES;
	[scene addChild: layer];
	return scene;
}

-(void)loadData
{
    NSString *bgPlist = @"background.plist";
    NSString *fgPlist = @"foreground.plist";
    NSString *spPlist = @"sprites.plist";
    NSString *sSheet = @"sprites.pvr.ccz";
    //加载当前场景需要用到的图片资源到精灵帧缓存
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:bgPlist];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:fgPlist];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:spPlist];

    //添加草地，注意，主要是add时候的深度参数，因为等会还有鼹鼠要出来，精灵的深度应该是，前面的一个块草地，鼹鼠，后面的草地
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    CCSprite *grassUp = [CCSprite spriteWithSpriteFrameName:@"grass_upper.png"];
    grassUp.position = CGPointMake(winSize.width/2, winSize.height/2);
    grassUp.anchorPoint = CGPointMake(0.5, 0);
    [self addChild:grassUp z:-1];

    CCSprite *grassLow = [CCSprite spriteWithSpriteFrameName:@"grass_lower.png"];
    grassLow.position = CGPointMake(winSize.width/2, winSize.height/2);
    grassLow.anchorPoint = CGPointMake(0.5, 1);
    [self addChild:grassLow z:1];
    
    score = 0;
    scoreLabel = [CCLabelTTF labelWithString:@"击中 0 只鼹鼠" fontName:@"Georgia-BoldItalic" fontSize:25];
    scoreLabel.tag = 101;
    scoreLabel.position = CGPointMake(winSize.width/2, winSize.height-20);
    [self addChild:scoreLabel];
    //生成3只鼹鼠
    moles = [[NSMutableArray alloc] init];
    CCSpriteBatchNode *spriteNode = [CCSpriteBatchNode batchNodeWithFile:sSheet];
    //[[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:spPlist];  
    for (int i = 0; i < 3; i++) {
        Mole *m = [Mole mole];
        m.position = CGPointMake(80+160*i, 85);
        m.active = NO;
        [spriteNode addChild:m];//添加进场景中
        [moles addObject:m];
    }
    [self addChild:spriteNode z:0];
    
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super's" return value
	if( (self=[super init]) ) {
        
        [self loadData];
        [self schedule:@selector(moleStartPop:) interval:1];
        
	}
	return self;
}

#pragma mark 鼹鼠走起
-(void)moleStartPop:(ccTime)dt
{
    for (Mole *mole in moles) {
        if (arc4random() % 3 == 0) {
            if (!mole.active) {
                mole.active = YES;
                [mole popMole];
            }
        } 
       
    }
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
   // UITouch *touch =  [touches anyObject];
//    CGPoint toucgPoint = [touch locationInView:[touch view]];
     CGPoint toucgPoint = [self convertTouchToNodeSpace:touch];
    for (Mole *mole in moles) {
        
        if (mole.isLaguh) {
            
            //            CGRect moleRect = CGRectMake(mole.position.x - (mole.contentSize.width/2), 
            //                                         mole.position.y - (mole.contentSize.height/2), 
            //                                         mole.contentSize.width, 
            //                                         mole.contentSize.height);
            
            if (CGRectContainsPoint(mole.boundingBox,toucgPoint)) {
                [mole thumpMole];
                score++;
                scoreLabel.string = [NSString stringWithFormat:@"击中了 %d 只鼹鼠",score];
            } 
        }
    }

    return YES;
}


- (void)registerWithTouchDispatcher
{
    [[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:NO];
}

#pragma mark 监听触摸
-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}


// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}

@end

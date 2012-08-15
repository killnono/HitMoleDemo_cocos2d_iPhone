//
//  MenuNode.m
//  LoadingSim
//
//  Created by Nono on 12-7-17.
//  Copyright (c) 2012年 NonoWithLilith. All rights reserved.
//

#import "MenuScene.h"
#import "LoadScene.h"
@implementation MenuNode
+ (CCScene*)scene
{
    CCScene *scene = [CCScene node];
    
    MenuNode *menu = [MenuNode node];
    [scene addChild:menu];
    return scene;
}

- (id)init
{
   
    self = [super init];
    if (self) {

        CCMenuItemFont *item1 = [CCMenuItemFont itemWithString:@"开始新游戏" block:^(id sender) {
            //开始新游戏
            [[CCDirector sharedDirector] replaceScene:[LoadScene sceneWithTargetScene:TargetSceneFirstScene]];
        }];
        
        CCMenuItemFont *item3 = [CCMenuItemFont itemWithString:@"载入游戏" block:^(id sender) {
            //开始新游戏
        }];
        
        CCMenuItemFont *item4 = [CCMenuItemFont itemWithString:@"游戏设置" block:^(id sender) {
            //开始新游戏
        }];
        
        //使用精灵创建一个item
        CCSprite *item2_nor = [CCSprite spriteWithFile:@"icon.png"];
        CCSprite *item2_sel = [CCSprite spriteWithFile:@"icon.png"];
        CCMenuItemSprite *item2 = [CCMenuItemSprite itemWithNormalSprite:item2_nor selectedSprite:item2_sel];
        
        
        CCMenu *menu = [CCMenu menuWithItems:item1,item3,item4,item2, nil];
        [menu alignItemsVerticallyWithPadding:20];
       CGSize win = [[CCDirector sharedDirector] winSize];
        menu.position = CGPointMake(win.width/2, 0);
        id action = [CCMoveTo actionWithDuration:2 position: CGPointMake(win.width/2, win.height/2)];
        id inAction = [CCEaseIn actionWithAction:action rate:5];
        [menu runAction:inAction];
        [self addChild:menu];
    }
    return self;
}

@end

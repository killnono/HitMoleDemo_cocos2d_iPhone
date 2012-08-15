//
//  Mole.h
//  LoadingSim
//
//  Created by Nono on 12-7-19.
//  Copyright (c) 2012年 NonoWithLilith. All rights reserved.
//

#import "CCSprite.h"
#import "cocos2d.h"

@interface Mole : CCSprite 
{
  
    BOOL active;
    BOOL isLaguh;

}

@property(nonatomic)BOOL active;
@property(nonatomic)BOOL isLaguh;
+(id)mole;
-(void)popMole;
-(void)thumpMole;
@end

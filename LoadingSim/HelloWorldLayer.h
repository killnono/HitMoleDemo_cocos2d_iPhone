//
//  HelloWorldLayer.h
//  LoadingSim
//
//  Created by Nono on 12-7-17.
//  Copyright NonoWithLilith 2012年. All rights reserved.
//

// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"

// HelloWorldLayer
@interface HelloWorldLayer : CCLayer
{
    //用来存放鼹鼠
    NSMutableArray *moles;
    CCLabelTTF *scoreLabel;
    int score;
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

@end

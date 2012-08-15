//
//  LoadScene.h
//  LoadingSim
//
//  Created by Nono on 12-7-17.
//  Copyright (c) 2012年 NonoWithLilith. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "cocos2d.h"
typedef enum{
    TargetSceneINVALID = 0,
	TargetSceneFirstScene
} TargetScenes;

@interface LoadScene : CCScene
{
    TargetScenes tag;
}
+(id)sceneWithTargetScene:(TargetScenes)targetScene;
@end

//
//  LevelSelectScene.h
//  jumpa
//
//  Created by harry on 3/01/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface LevelSelectScene : Scene {

	Sprite *stars_scrolling;
	Sprite *stars_scrolling2;
	
	Scene *levelSelectLayer;
}

+ (LevelSelectScene*)sharedLevelSelectScene;

@end

//
//  MenuScene.h
//  Untitled
//
//  Created by Harry Potter on 2/07/09.
//  Copyright Synthesia 2009. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "cocos2d.h"
#import "SFXManager.h"
//#import "GameScene.h"


@interface GameOverScene : Scene 
{	
	
}


@end

@interface GameOverLayer : Layer
{
	MenuItemImage *gameOverImage;
	Menu *menu;
}

@end

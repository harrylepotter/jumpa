//
//  MenuScene.h
//  Untitled
//
//  Created by Harry Potter on 2/07/09.
//  Copyright Synthesia 2009. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "cocos2d.h"
#import "MapScene.h"
#import "SFXManager.h"
#import "LevelSelectScene.h"


@interface MenuScene : Scene 
{	
	id ml;
	
}


@end

@interface MenuLayer : Layer
{
	MenuItemImage *splash;
	Menu *menu;
	id fadeout_action;
	id fadeout_finished;
	id seq;
	id fadein_action;
	id gs;
}
-(void)startGame: (id)sender;
-(void)help: (id)sender;
@end

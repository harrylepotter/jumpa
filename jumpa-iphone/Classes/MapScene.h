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
#import "RCMusicItem.h"
#import "RCMusicManager.h"
#import "MusicFadeAction.h"

//#import "GameScene.h"


@interface MapScene : Scene 
{	
	id ml;
	id gs;
}


@end

@interface MapLayer : Layer
{
	Sprite *complete;
	Sprite *splash;
	Sprite *mask1;
	Sprite *mask2;
	Sprite *mask3;
	Sprite *fader_blackness;
	
	int masklevel;
	id mask_fadeout;
	
	
	
	
	// TODO : SHARED GAME SCENE
	
	id gs;
	
	
	id fadeout_action;
	id fadeout_sound;
	id fadeout_finished;
	id seq;
	id fadein_action;
	id seq_startgame;
	
	
	Sprite *stars_scrolling;
	Sprite *stars_scrolling2;
	
	Sprite *level1;
	Sprite *level1_start;
	
	

	
}
-(void)startGame: (id)sender;
-(void)help: (id)sender;
@end

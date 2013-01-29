//
//  LoadingScene.h
//  jumpa
//
//  Created by harry on 5/10/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "jumpaMoviePlayer.h"



@interface LoadingLayer : Layer
{
	Sprite *voidNode;
	id fadeout;
	id fadein;
	id end_callback;
	id end_loading_seq;
	id start_loading_seq;
	id finished_fade_in;
	id run_loop_action;
	id run_action;
	AtlasSpriteManager *runmgr;
	AtlasSprite *run;
	Sprite *loadingScreen;
	jumpaMoviePlayer *moviePlayer;
	
}



@end


@interface LoadingScene : Scene {
	LoadingLayer *loadingscreen;
	BOOL isLoaded;
}

@end

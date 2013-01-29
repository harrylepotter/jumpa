//
//  oxyMeterLayer.h
//  jumpa
//
//  Created by harry on 5/05/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "MusicFadeAction.h"
#import "RCMusicItem.h"
#import "RCMusicManager.h"

@interface oxyMeterLayer : Layer {

	AtlasSpriteManager *layer1_mgr;
	AtlasSpriteManager *layer2_mgr;
	AtlasSpriteManager *layer3_mgr;
	AtlasSpriteManager *layer4_mgr;
	
	AtlasSprite *layer1;
	AtlasSprite *layer2;
	AtlasSprite *layer3;
	AtlasSprite *layer4;
	
	CocosNode *soundNode;
	//startOxy
	id startOxy_seq;
	
	id redOxy_seq;
	id redOxy_blink;
	
	id blueOxy_refresh_seq;
	id redOxy_refresh_seq;
	
	id sound_refresh_action;
	id sound_cutoff_action;
	
	RCMusicItem *music;
}

+ (oxyMeterLayer *)sharedOxyMeter;

-(void)initOxyActions;
-(void)initRedFlashingActions;
-(void)initRefreshActions;

@end

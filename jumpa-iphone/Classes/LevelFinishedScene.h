//
//  LevelFinishedScene.h
//  jumpa
//
//  Created by harry on 10/03/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "starEmitter.h"
#import "RCMusicManager.h"
#import "RCMusicItem.h"
#import "creditMeterLayer.h"
#import "easymenuitem.h"
#import "mediummenuitem.h"
#import "hardmenuitem.h"
#import "extememenuitem.h"
#import "difficultymenuitem.h"

@interface LevelFinishedLayer : Layer{
	id run_loop_action;
	id run_action;
	id move_to;
	id spawner;
	AtlasSpriteManager *runmgr;
	AtlasSprite *run;
	Sprite *voidNode;
	
	
	// labels 
	LabelAtlas *oxyLabel;
	LabelAtlas *creditLabel;
	LabelAtlas *lifeLabel;
	
	
	// symbols
	// lives
	AtlasSpriteManager *livesMgr;
	AtlasSprite *livesSymbol;
	AtlasAnimation *livesAnimation;
	id livesAnimationAction;
	BOOL livesAnimationShown;
	
	//credits
	AtlasSpriteManager *creditsMgr;
	AtlasSprite *creditsSymbol;
	AtlasAnimation *creditsAnimation;
	id creditsAnimationAction;
	BOOL credisAnimationShown;
	
	
	BOOL is_next_level_unlocked;
	
	
	//credit meter
	creditMeterLayer *creditMeter;
	
	

	//values 
	int credits;
	int creditsCount;
	int initialNumCredits;
	int maxScore;
	int livesVal;
	float heart_threshold_score;	
	
	
	
	difficultymenuitem *currentLevelBadge;
	difficultymenuitem *nextLevelBadge;
	
	
	BOOL show_unlocked_sprite;
	BOOL show_heart_unlocked_sprite;
	
	
	LabelAtlas *heartUnlockedLabel;
	LabelAtlas *levelUnlockedLabel;
	

}
@end

@interface LevelFinishedScene : Scene{

}
-(id) initWithCreditsScore:(int)creditsamt livesScore:(int)livesScore;

@end

//
//  GameScene.h
//  Untitled
//
//  Created by Harry Potter on 2/07/09.
//  Copyright Synthesia 2009. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "cocos2d.h"
#import "JumpaAnimation.h"
#import "TerrainLayer.h"
#import "JumpaCharacterLayer.h"
#import "jumpaAppDelegate.h"
#import "collisionphysics.h"
#import "EnemyLayer.h"
#import "boundedSprite.h"
#import "creditsLayer.h"
#import "jumpMeterLayer.h"
#import "backgroundLayer.h"
#import "constants.h"
#import "SFXManager.h"
#import "CheckpointLayer.h"
#import "LevelFinishedScene.h"
#import "LevelFinishedOverlay.h"
#import "GameOverScene.h"
#import "RCMusicManager.h"
#import "RCMusicItem.h"
#import "MusicFadeAction.h"
#import "creditMeterLayer.h"

@interface GameLayer : Layer
{
	JumpaCharacterLayer *jumpaCharacter;
	CGRect charbounds;
	CGPoint abspos;
	CGRect absoluteBounds;
	

	
	
}
@property (readonly) CGRect charbounds;
@property (readonly) CGPoint abspos;
@property (readonly) CGRect absoluteBounds;

@end


@interface GameScene : Scene 
{

		
	CocosNode *voidNode;
	
	CocosNode *soundNode;
	backgroundLayer *parralaxBackgrounds;
	CocosNode *backgroundNode;
	
	
	RCMusicItem *level1Music;	
	
	TerrainLayer *terrain;	
	GameLayer *gaminglayer;
	EnemyLayer *enemiesLayer;
	creditsLayer *credits;
	collisionphysics *physics;
	
	jumpMeterLayer *jumpMeter;
	
	float level_width;
	
	float movement;
	
	Sprite *staticBackground;
	
	
	//CocosNode *overlayNode;
	Sprite *gameOverSprite;
	
	
	// actions 
	id sometime;
	id sometime2;
	id fadeout;
	id restart_game;
	id end_game;
	id fadein;
	id gameover_fadeout_seq;
	
	// character death
	id movementcallback;
	id sometime3;
	id death_fadeout_seq;
	
	// initial fade in 
	id initial_fade_in;
	
	BOOL level_finished;
	
	
	SFXManager *soundmgr;
	// checkpoint layer
	CheckpointLayer *checkpointLayer;
	
	CGPoint spawn_point;
	
	Sprite *fader_blackness;
	Sprite *level1;
	Sprite *level1_start;
	id level1_seq;
	id start_seq;
	

	
	// audio specific actions
	id mapVolumeActionHolder;
	id level1VolumeActionHolder;
	id music_bendUp;
	id music_bendDown;
	
	
	// speed up actions 
	id character_speed_action;
	
	
	Sprite *caveBack;
	Sprite *blackness;
	Sprite *caveFront;
	
	NSString *levelname;
	
	BOOL paused;
	
}

+ (GameScene *)sharedGameScene;
-(NSString*)getLevelName;
-(void)setLevel:(NSDictionary*)level name:(NSString*)name;
-(BOOL)togglePause;

@property (nonatomic, retain) collisionphysics *physics;
@end


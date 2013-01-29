//
//  JumpaCharacterLayer.h
//  Untitled
//
//  Created by Harry Potter on 19/08/09.
//  Copyright 2009 Synthesia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "JumpaAnimation.h"
#import "TerrainLayer.h"
#import "JumpaCharacterLayer.h"
#import "bloodemitter.h"
#import "jumpMeterLayer.h"
#import "constants.h"
#import "boundedSprite.h"
#import "SFXManager.h"

@interface JumpaCharacterLayer : Layer 
{
	
	
	AtlasSpriteManager *jumpaSpriteMgr;
	
	
	bloodEmitter *be;
	
	int current_state;
	int last_state;
	
	
	JumpaSprite *jump1Up;
	JumpaSprite *fall;
	JumpaSprite *death;
	JumpaSprite *jump2Up;
	JumpaSprite *jump3Up;
	JumpaSprite *hang;
	AtlasSprite *run;
	
	
	
	AtlasSpriteManager *jump1mgr;
	AtlasSpriteManager *jump2mgr;
	AtlasSpriteManager *jump3mgr;
	AtlasSpriteManager *hangmgr;
	AtlasSpriteManager *deathmgr;
	AtlasSpriteManager *fallmgr;
	AtlasSpriteManager *runmgr;
	
	JumpaAnimation *jump1anim;
	JumpaAnimation *jump2anim;
	JumpaAnimation *jump3anim;
	JumpaAnimation *hanganim;
	JumpaAnimation *fallanim;
	JumpaAnimation *death_initialshock_anim;
	JumpaAnimation *death_fall_anim;
	AtlasAnimation *runanim;
	
	Sprite *landingSprite;
	
	
	//re-usable actions
	id action_finished_jumping;
	
	id jump1_jump_action;
	id jump1_seq;
	
	id jump2_jump_action;
	id jump2_seq;
	
	id jump3_jump_action;
	id jump3_seq;
	
	id hang_action;
	id hang_action_repeater;
	id hang_waiter_delay;
	id hang_waiter_callback;
	id hang_waiter;
	
	id land_run_waitabit;
	id land_putInRunningLoop;
	id land_seq;
	
	id run_action;
	id run_loop_action;
	
	id fall_hang_delay;
	id fall_commence;
	id falling_anim_delay;
	id fall_action;
	id fall_reveal_jumpa;
	id fall_transition;
	id fall_easein;
	id fall_seq1;
	id fall_seq2;
	id fall_spawn;
	
	
	id death_action;
	id death_fall_action;
	id death_fall_animation;
	id death_falling_transition;
	id death_blood_on;
	id death_finished;
	id death_seq;
	
	CGPoint startpoint;
	CGPoint current_point;
	
	ccTime hangtime;
	
	
	CGRect charbounds;
	CGPoint abspos;
	CGRect absoluteBounds;

	BOOL touches_down;
	
	/* externally referenced objects */
	jumpMeterLayer *hud;
	SFXManager *sfx;
	
	/* Credits count */
	int creditsCount;
	int livesCount;
	
}

-(void) cleanUp;
@property (readonly) int current_state;
@property (readonly) CGRect charbounds;
@property (readonly) CGPoint abspos;
@property (readonly) CGRect absoluteBounds;
@property (nonatomic, retain) jumpMeterLayer *hud;
@property (nonatomic, retain) SFXManager *sfx;


@end
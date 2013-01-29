//
//  JumpaCharacterLayer.m
//  Untitled
//
//  Created by Harry Potter on 19/08/09.
//  Copyright 2009 Synthesia. All rights reserved.
//

#import "JumpaCharacterLayer.h"
#define INITIAL_LIVES_COUNT 1



@implementation JumpaCharacterLayer
@synthesize charbounds;
@synthesize abspos;
@synthesize absoluteBounds;
@synthesize hud;
@synthesize sfx;
@synthesize current_state;


- (id) init {
    self = [super init];
    if (self != nil) {
		
        isTouchEnabled = YES;
		creditsCount = 0;
		livesCount = INITIAL_LIVES_COUNT;
		[self initAssets];
		
			// respond to suffocation
		[[NSNotificationCenter defaultCenter] addObserver:self
												 selector:@selector(suffocate:)
													 name:@"suffocate" object:nil];

	}
	
	
	
    return self;
}

-(void)suffocate:(NSNotification *)notification
{
	//NSLog(@"oxymeter: suffocate");
	[[NSNotificationCenter defaultCenter] postNotificationName:@"disableCollisions" object:self];
	[self switchStates:STATE_DYING point:ccp(self.charbounds.origin.x, self.charbounds.origin.y)];
	//[self doDeathFromPoint:ccp(self.charbounds.origin.x, self.charbounds.origin.y)];
}

-(void)initAssets{
	//[Texture2D setAliasTexParameters];
	CGPoint point = ccp(0,0);
	
	if(jump1mgr == nil){
		
		jump1mgr = [AtlasSpriteManager spriteManagerWithFile:@"jump1_up.png" capacity:50];
		
		[self addChild:jump1mgr z:0 tag:10];
		jump1Up = [JumpaSprite spriteWithRect:CGRectMake(0, 0, 90, 220) spriteManager: jump1mgr];
		jump1Up.tag = 11;
		
		jump1anim = [[JumpaAnimation animationWithName:@"jump1_up" delay:0.05] retain];
		//jump1anim = [[JumpaAnimation animationWithName:@"jump1_up" delay:1.5] retain];
		
		//1: (14,9) , (69,52)
		CGRect frame1bound = CGRectMake(point.x + 25.0, point.y + 9.0, 35.0, 44.0);
		//2: (16,16) , (64,45)
		CGRect frame2bound = CGRectMake(point.x + 25.0, point.y + 16.0, 35.0, 38.0);
		//3: (33,16), (34,91)
		CGRect frame3bound = CGRectMake(point.x + 38.0, point.y + 16.0, 16.0, 75.0);
		//4: (33,47), (34, 91)
		CGRect frame4bound = CGRectMake(point.x + 38.0, point.y + 47.0, 16.0, 70.0);
		//5: (33,64), (42, 87)
		CGRect frame5bound = CGRectMake(point.x + 38.0,  point.y + 84.0, 16.0, 77.0);
		//6: (18,124), (49,81)
		CGRect frame6bound = CGRectMake(point.x + 36.0,  point.y + 124.0, 20.0, 65.0);
		//7: (14, 160), (70,56)
		CGRect frame7bound = CGRectMake(point.x + 29.0,  point.y + 160.0, 30.0, 45.0);
		//8: (7, 169) , (76, 50)
		CGRect frame8bound = CGRectMake(point.x + 31.0,  point.y + 169.0, 30.0, 45.0);
		
		
		//add frames with boundaries to the set of animation frames
		// NOTE: NEED TO FIND A WAY OF EXTENDNG UPDATE FUNCTION SO WE KNOW 
		// WHERE THE CHARACTER IS AT ALL TIMES
		[jump1anim addFrameWithRect: CGRectMake(0, 0, 90, 220) bounds:frame1bound ];
		[jump1anim addFrameWithRect: CGRectMake(90, 0, 90, 220) bounds:frame2bound ];
		[jump1anim addFrameWithRect: CGRectMake(180, 0, 90, 220) bounds:frame3bound ];
		[jump1anim addFrameWithRect: CGRectMake(270, 0, 90, 220) bounds:frame4bound ];
		[jump1anim addFrameWithRect: CGRectMake(360, 0, 90, 220) bounds:frame5bound ];
		[jump1anim addFrameWithRect: CGRectMake(450, 0, 90, 220) bounds:frame6bound ];
		[jump1anim addFrameWithRect: CGRectMake(540, 0, 90, 220) bounds:frame7bound ];
		[jump1anim addFrameWithRect: CGRectMake(630, 0, 90, 220) bounds:frame8bound ];
		
		// add the sprite to the atlas sprite manager 
		[jump1mgr addChild:jump1Up];
		
		jump1_jump_action = [[JumpaAnimate actionWithAnimation: jump1anim] retain];
		action_finished_jumping = [[CallFunc actionWithTarget:self selector:@selector(finishedJump)] retain];
		
		
		jump1_seq = [[Sequence actions:
				   jump1_jump_action,
				   action_finished_jumping,
					  nil] retain];	
		
		
		
		
	} 
	
	if(jump2mgr == nil){
		current_state = STATE_JUMP2;
		
		
		jump2mgr = [AtlasSpriteManager spriteManagerWithFile:@"jump2_up.png" capacity:50];
		[self addChild:jump2mgr z:0 tag:10];
		jump2Up = [JumpaSprite spriteWithRect:CGRectMake(0, 0, 90, 230) spriteManager: jump2mgr];
		jump2Up.tag = 11;
		jump2anim = [[JumpaAnimation animationWithName:@"jump2_up" delay:0.05] retain];
		//jump2anim = [[JumpaAnimation animationWithName:@"jump2_up" delay:1.5] retain];

		
		//	1: (18,19) , (63,39)
		CGRect frame1bound = CGRectMake(point.x + 18.0, point.y + 19.0, 63.0, 39.0);
		//	2: (18,19) , (63,39)
		CGRect frame2bound = CGRectMake(point.x + 18.0, point.y + 19.0, 63.0, 39.0);
		//	3: (28,19), (34,82)
		CGRect frame3bound = CGRectMake(point.x + 28.0, point.y + 19.0, 34.0, 82.0);
		//	4: (24,55), (36,81)
		CGRect frame4bound = CGRectMake(point.x + 24.0, point.y + 55.0, 36.0, 81.0);
		//	5: (25,86), (33,70)
		CGRect frame5bound = CGRectMake(point.x + 25.0, point.y + 86.0, 33.0, 70.0);
		//	6: (25,127), (41,50)
		CGRect frame6bound = CGRectMake(point.x + 25.0, point.y + 127.0, 41.0, 50.0);
		//	7: (18,156), (53,42)
		CGRect frame7bound = CGRectMake(point.x + 18.0, point.y + 156.0, 53.0, 42.0);
		//	8: (19,166) , (54,49)
		CGRect frame8bound = CGRectMake(point.x + 19.0, point.y + 166.0, 54.0, 49.0);
		//	9: (19,172),  (51,53)
		CGRect frame9bound = CGRectMake(point.x + 19.0, point.y + 172.0, 51.0, 53.0);
		//	10: (30,170) , (39,58)
		CGRect frame10bound = CGRectMake(point.x + 30.0, point.y + 170.0, 39.0, 58.0);
		//	11: (15,176) , (61,49)
		CGRect frame11bound = CGRectMake(point.x + 35.0, point.y + 176.0, 30.0, 49.0);
		
		
		
		
		//add frames with boundaries to the set of animation frames
		// NOTE: NEED TO FIND A WAY OF EXTENDNG UPDATE FUNCTION SO WE KNOW 
		// WHERE THE CHARACTER IS AT ALL TIMES
		[jump2anim addFrameWithRect: CGRectMake(0*90, 0, 90, 230) bounds:frame1bound ];
		[jump2anim addFrameWithRect: CGRectMake(1*90, 0, 90, 230) bounds:frame2bound ];
		[jump2anim addFrameWithRect: CGRectMake(2*90, 0, 90, 230) bounds:frame3bound ];
		[jump2anim addFrameWithRect: CGRectMake(3*90, 0, 90, 230) bounds:frame4bound ];
		[jump2anim addFrameWithRect: CGRectMake(4*90, 0, 90, 230) bounds:frame5bound ];
		[jump2anim addFrameWithRect: CGRectMake(5*90, 0, 90, 230) bounds:frame6bound ];
		[jump2anim addFrameWithRect: CGRectMake(6*90, 0, 90, 230) bounds:frame7bound ];
		[jump2anim addFrameWithRect: CGRectMake(7*90, 0, 90, 230) bounds:frame8bound ];
		[jump2anim addFrameWithRect: CGRectMake(8*90, 0, 90, 230) bounds:frame9bound ];
		[jump2anim addFrameWithRect: CGRectMake(9*90, 0, 90, 230) bounds:frame10bound ];
		//[jump2anim addFrameWithRect: CGRectMake(10*90, 0, 90, 230) bounds:frame11bound ];
		
		// add the sprite to the atlas sprite manager 
		[jump2mgr addChild:jump2Up];
		
		jump2_jump_action = [[JumpaAnimate actionWithAnimation: jump2anim] retain];
		
		
		jump2_seq = [[Sequence actions:
				   jump2_jump_action,
				   action_finished_jumping,
				   nil] retain];	
		
		
	}
	
	if(jump3mgr == nil){
		jump3mgr = [AtlasSpriteManager spriteManagerWithFile:@"jump3.png" capacity:50];
		[self addChild:jump3mgr z:0 tag:10];
		jump3Up = [JumpaSprite spriteWithRect:CGRectMake(0, 0, 100, 220) spriteManager: jump3mgr];
		jump3Up.tag = 11;
		jump3anim = [[JumpaAnimation animationWithName:@"jump3_up" delay:0.05] retain];
		//jump3anim = [[JumpaAnimation animationWithName:@"jump3_up" delay:1.5] retain];
		
		
		//	1: (28,25) , (54,45)
		CGRect frame1bound = CGRectMake(point.x + 28.0, point.y + 25.0, 54.0, 45.0);
		//	2: (46,32) , (37,80)
		CGRect frame2bound = CGRectMake(point.x + 46.0, point.y + 32.0, 37.0, 80.0);
		//		3: (45,75), (34,75)
		CGRect frame3bound = CGRectMake(point.x + 45.0, point.y + 75.0, 34.0, 75.0);
		//		4: (27,110), (61,68)
		CGRect frame4bound = CGRectMake(point.x + 27.0, point.y + 110.0, 61.0, 68.0);
		//		5: (23,144), (62,48)
		CGRect frame5bound = CGRectMake(point.x + 23.0, point.y + 144.0, 62.0, 48.0);
		//	6: (40,135), (49,70)
		CGRect frame6bound = CGRectMake(point.x + 40.0, point.y + 135.0, 49.0, 70.0);
		//		7: (33,145), (50,68)
		CGRect frame7bound = CGRectMake(point.x + 33.0, point.y + 145.0, 50.0, 68.0);
		//	8: (19,155) , (68,42)
		CGRect frame8bound = CGRectMake(point.x + 19.0, point.y + 155.0, 68.0, 42.0);
		//	9: (23,155),  (60,48)
		CGRect frame9bound = CGRectMake(point.x + 23.0, point.y + 155.0, 60.0, 48.0);
		//	10: (29,150) , (60,56)
		CGRect frame10bound = CGRectMake(point.x + 29.0, point.y + 150.0, 60.0, 56.0);
		//	11: (22,164) , (70,44)
		CGRect frame11bound = CGRectMake(point.x + 22.0, point.y + 164.0, 70.0, 44.0);
		
		
		[jump3anim addFrameWithRect: CGRectMake(0*100, 0, 100, 220) bounds:frame1bound ];
		[jump3anim addFrameWithRect: CGRectMake(1*100, 0, 100, 220) bounds:frame2bound ];
		[jump3anim addFrameWithRect: CGRectMake(2*100, 0, 100, 220) bounds:frame3bound ];
		[jump3anim addFrameWithRect: CGRectMake(3*100, 0, 100, 220) bounds:frame4bound ];
		[jump3anim addFrameWithRect: CGRectMake(4*100, 0, 100, 220) bounds:frame5bound ];
		[jump3anim addFrameWithRect: CGRectMake(0*100, 220, 100, 220) bounds:frame6bound ];
		[jump3anim addFrameWithRect: CGRectMake(1*100, 220, 100, 220) bounds:frame7bound ];
		[jump3anim addFrameWithRect: CGRectMake(2*100, 220, 100, 220) bounds:frame8bound ];
		[jump3anim addFrameWithRect: CGRectMake(3*100, 220, 100, 220) bounds:frame9bound ];
		//[jump3anim addFrameWithRect: CGRectMake(4*100, 220, 100, 220) bounds:frame10bound ];
		//[jump3anim addFrameWithRect: CGRectMake(0*100, 440, 100, 220) bounds:frame11bound ];
		
		// add the sprite to the atlas sprite manager 
		[jump3mgr addChild:jump3Up];
		
		jump3_jump_action = [[JumpaAnimate actionWithAnimation: jump3anim] retain];
		
		
		jump3_seq = [[Sequence actions:
				   jump3_jump_action,
				   action_finished_jumping,
				   nil] retain];	
		
	}
	
	if(hangmgr == nil){
		hangmgr = [AtlasSpriteManager spriteManagerWithFile:@"JumpaFall.png" capacity:50];
		[self addChild:hangmgr z:0 tag:10];
		hang = [JumpaSprite spriteWithRect:CGRectMake(0, 0, 68, 83) spriteManager: hangmgr];
		hang.tag = 11;
		
		hanganim = [[JumpaAnimation animationWithName:@"jump1_hang" delay:0.01] retain];
		
		CGRect frame1bound = CGRectMake(point.x, point.y, 68.0, 37.0);
		
		[hanganim addFrameWithRect: CGRectMake(0*68, 0, 68, 83) bounds:frame1bound ];
		
		[hangmgr addChild:hang];
		
		hang_action = [[Animate actionWithAnimation: hanganim] retain];
		
		hang_action_repeater = [[RepeatForever actionWithAction:hang_action] retain];
		
		hang_waiter_delay = [[DelayTime actionWithDuration:0.01] retain];
		hang_waiter_callback = [[CallFunc actionWithTarget:self selector:@selector(finishHang)] retain];
		hang_waiter = [[Sequence actions:hang_waiter_delay, hang_waiter_callback, nil] retain];
	}
	
	if(fallmgr == nil){
		fallmgr = [AtlasSpriteManager spriteManagerWithFile:@"JumpaFall.png" capacity:5];
		[self addChild:fallmgr z:0 tag:10];
		
		fall = [JumpaSprite spriteWithRect:CGRectMake(0, 0, 68, 83) spriteManager: fallmgr];
		fall.tag = 12;
		fallanim = [[JumpaAnimation animationWithName:@"fall" delay:0.08] retain];
		//fallanim = [[JumpaAnimation animationWithName:@"fall" delay:1.0] retain];
		
		CGRect frame1bound = CGRectMake(point.x, point.y, 68.0, 83.0);
		CGRect frame2bound = CGRectMake(point.x, point.y, 68.0, 83.0);
		CGRect frame3bound = CGRectMake(point.x, point.y, 68.0, 83.0);
		CGRect frame4bound = CGRectMake(point.x, point.y, 68.0, 83.0);
		
		
		[fallanim addFrameWithRect: CGRectMake(0*68, 0, 68, 83) bounds:frame1bound ];
		[fallanim addFrameWithRect: CGRectMake(1*68, 0, 68, 83) bounds:frame2bound ];
		[fallanim addFrameWithRect: CGRectMake(2*68, 0, 68, 83) bounds:frame3bound ];
		[fallanim addFrameWithRect: CGRectMake(3*68, 0, 68, 83) bounds:frame4bound ];	
		//[fallanim addFrameWithRect: CGRectMake(0*68, 0, 68, 83) bounds:frame1bound ];
		
		
		charbounds.size.width = 68;
		charbounds.size.height = 83;
		
		[fallmgr addChild:fall];
		
		
		fall_hang_delay = [[DelayTime actionWithDuration:0.05f] retain];
		falling_anim_delay = [[DelayTime actionWithDuration:0.10f] retain];
		fall_action = [[JumpaAnimate actionWithAnimation: fallanim] retain];
		fall_reveal_jumpa = [[CallFunc actionWithTarget:self selector:@selector(revealJumpa)] retain];
		fall_seq1 = [[Sequence actions:
				   //falling_anim_delay,
				   fall_reveal_jumpa,
				   fall_action,
				   nil] retain];
		
		fall_transition = [[MoveTo actionWithDuration:5.0f position:ccp(startpoint.x,-100)] retain];
		fall_commence = [[CallFunc actionWithTarget:self selector:@selector(fallingCommenced)] retain];

		
	}

	if (deathmgr == nil) {
		
		deathmgr = [AtlasSpriteManager spriteManagerWithFile:@"JumpaDie.png" capacity:12];
		[self addChild:deathmgr z:0 tag:10];
		
		//death = [JumpaSprite spriteWithRect:CGRectMake(68, 0, 92, 112) spriteManager: deathmgr];
		death = [JumpaSprite spriteWithRect:CGRectMake(0, 0, 92, 112) spriteManager: deathmgr];
		death.tag = 13;
		

		
		death_initialshock_anim = [[JumpaAnimation animationWithName:@"death" delay:0.06] retain];
		death_fall_anim = [[JumpaAnimation animationWithName:@"deathfall" delay:0.2] retain];	
		
		CGRect frame1bound = CGRectMake(point.x, point.y, 92.0, 112.0);
		
//		for(int i=0;i<10;i++) {
//			int x= i % 5;
//			int y= i / 5;
//			[death_initialshock_anim addFrameWithRect: CGRectMake(x*92, y*112, 92, 112) bounds:frame1bound];
//		}
		
		[death_initialshock_anim addFrameWithRect: CGRectMake(0*92, 0*112, 92, 112) bounds:frame1bound];
		[death_initialshock_anim addFrameWithRect: CGRectMake(0*92, 0*112, 92, 112) bounds:frame1bound];
		[death_initialshock_anim addFrameWithRect: CGRectMake(0*92, 0*112, 92, 112) bounds:frame1bound];
		[death_initialshock_anim addFrameWithRect: CGRectMake(0*92, 0*112, 92, 112) bounds:frame1bound];
		[death_initialshock_anim addFrameWithRect: CGRectMake(1*92, 0*112, 92, 112) bounds:frame1bound];
		[death_initialshock_anim addFrameWithRect: CGRectMake(2*92, 0*112, 92, 112) bounds:frame1bound];
		[death_initialshock_anim addFrameWithRect: CGRectMake(3*92, 0*112, 92, 112) bounds:frame1bound];
		[death_initialshock_anim addFrameWithRect: CGRectMake(4*92, 0*112, 92, 112) bounds:frame1bound];
		[death_initialshock_anim addFrameWithRect: CGRectMake(0*92, 1*112, 92, 112) bounds:frame1bound];
		[death_initialshock_anim addFrameWithRect: CGRectMake(1*92, 1*112, 92, 112) bounds:frame1bound];
		[death_initialshock_anim addFrameWithRect: CGRectMake(2*92, 1*112, 92, 112) bounds:frame1bound];
		[death_initialshock_anim addFrameWithRect: CGRectMake(3*92, 1*112, 92, 112) bounds:frame1bound];
		[death_initialshock_anim addFrameWithRect: CGRectMake(4*92, 1*112, 92, 112) bounds:frame1bound];


		[death_fall_anim addFrameWithRect: CGRectMake(3*92, 1*112, 92, 112) bounds:frame1bound];
		[death_fall_anim addFrameWithRect: CGRectMake(4*92, 1*112, 92, 112) bounds:frame1bound];
		
		

		[death addAnimation:death_initialshock_anim];
		[death addAnimation:death_fall_anim];
		
		[death setDisplayFrame:@"death" index:0];
		[death setDisplayFrame:@"deathfall" index:0];
//		
//		[death_fall_anim addFrameWithRect:CGRectMake((11%5)*92, (11/5)*112, 92, 112) bounds:frame1bound];
		
		charbounds.size.width = 92;
		charbounds.size.height = 112;
		
		[deathmgr addChild:death];
		
		death_action = [[Animate actionWithAnimation: death_initialshock_anim restoreOriginalFrame:YES] retain];
		death_fall_animation = [[Animate actionWithAnimation: death_fall_anim restoreOriginalFrame:YES] retain];
		death_falling_transition = [[MoveTo actionWithDuration:5.0f position:ccp(point.x, -200)] retain];
		death_blood_on = [[CallFunc actionWithTarget:self selector:@selector(deathBloodOn)] retain];
		death_finished = [[CallFunc actionWithTarget:self selector:@selector(finishedDeath)] retain];

		
	}
	
	if(runmgr == nil){
		runmgr = [AtlasSpriteManager spriteManagerWithFile:@"run.png" capacity:50];
		[self addChild:runmgr z:10 tag:1];
		
		run = [AtlasSprite spriteWithRect:CGRectMake(0, 0, 64, 74) spriteManager: runmgr];
		
		runanim = [[AtlasAnimation animationWithName:@"run" delay:0.06f] retain];
		
		for(int i=0;i<10;i++) {
			int x= i % 5;
			int y= i / 5;
			[runanim addFrameWithRect: CGRectMake(x*64, y*74, 64, 74) ];
			
		}
		
		
		[runmgr addChild:run];
		

		land_run_waitabit = [[DelayTime actionWithDuration:0.15f] retain];
		land_putInRunningLoop = [[CallFunc actionWithTarget:self selector:@selector(runningLoop)] retain];
		land_seq = [[Sequence actions:land_run_waitabit, land_putInRunningLoop, nil] retain];
		run_action = [[Animate actionWithAnimation: runanim] retain];
		run_loop_action = [[RepeatForever actionWithAction:run_action] retain];
		
		
	}
	
	be = [bloodEmitter node];
	[self add:be z:999 tag:999];
	[be setVisible:NO];
	
	
	// landing thing 
	landingSprite = [[boundedSprite makeWithFile:@"land.png" bounds:CGRectMake(0.0f,0.0f,0.0f,0.0f)] retain];
	landingSprite.transformAnchor = ccp(0.0,0.0);
	landingSprite.position = ccp(50.0f,90.0f);
	[self addChild:landingSprite];
	[landingSprite setVisible:NO];
	
	
	
	[self schedule:@selector(hangMeterChecker:)];
	

}

-(void)initSfx
{
	//NSLog(@"jumpaCharacterLayer: initSfx");
	[sfx addSound:@"Die_MusicEnd" gain:[NSNumber numberWithFloat:1.0f]];
	[sfx addSound:@"Hang1" gain:[NSNumber numberWithFloat:0.3f]];
	[sfx addSound:@"jump" gain:[NSNumber numberWithFloat:0.4f]];
	[sfx addSound:@"Jump1" gain:[NSNumber numberWithFloat:0.35f]];
	[sfx addSound:@"Jump2" gain:[NSNumber numberWithFloat:0.35f]];
	[sfx addSound:@"Jump3" gain:[NSNumber numberWithFloat:0.35f]];
	[sfx addSound:@"Landing1"gain:[NSNumber numberWithFloat:0.3f]];
	[sfx addSound:@"ReSpawn_MusicStart" gain:[NSNumber numberWithFloat:0.0f]];
	[sfx addSound:@"credit"gain:[NSNumber numberWithFloat:0.25f]];
	[sfx addLoop:@"Run" gain:[NSNumber numberWithFloat:0.1f]];
	[sfx addSound:@"CheckPoint" gain:[NSNumber numberWithFloat:0.1f]];
	
}
-(void)spawn{
	touches_down = NO;
	hangtime = 0.0f;
	startpoint = CGPointMake(0.0,-100.0);
	charbounds = CGRectMake(0.0, 100.0, 100.0, 100.0);
	absoluteBounds = CGRectMake(0.0,0.0,0.0,0.0);
	current_state = STATE_FALLING;
	last_state = STATE_NONE;
	current_point = ccp(0.0,0.0);
	abspos = ccp(0.0,100.0);
	[sfx playSound:@"ReSpawn_MusicStart" atPosition:self.position];
	[self switchStates:STATE_FALLING point:ccp(0.0,100.0)];
	[self updateLivesCount];
}

#pragma mark state switcher
-(void)switchStates:(int)toState point:(CGPoint) p{


	[jump1mgr setVisible:NO];
	[jump2mgr setVisible:NO];
	[jump3mgr setVisible:NO];
	[hangmgr setVisible:NO];
	[deathmgr setVisible:NO];
	[fallmgr setVisible:NO];
	[runmgr setVisible:NO];
	[landingSprite setVisible:NO];

	
	[jump1Up stopAllActions];
	[fall stopAllActions];
	[fallmgr stopAllActions];
	[death stopAllActions];
	[jump2Up stopAllActions];
	[jump3Up stopAllActions];
	[hang stopAllActions];
	[run stopAllActions];
	//[fallanim reset];
	
	
	current_point = p;
	
	// need to prevent hang from becoming last_state

	if(current_state != STATE_HANG){
		last_state = current_state;
	}
	current_state = toState;
	
	switch (toState) {
		case STATE_RUNNNING:
			//[runmgr setVisible:YES];
			[self doRunFromPoint:p];
			[hud setState:[NSNumber numberWithInt:STATE_JUMP1]];
			break;
		case STATE_JUMP1:
			[jump1mgr setVisible:YES];
			[self doJump1FromPoint:p];
			[hud setState:[NSNumber numberWithInt:STATE_JUMP1]];
			break;		
		case STATE_JUMP2:
			[jump2mgr setVisible:YES];
			[self doJump2FromPoint:p];
			 [hud setState:[NSNumber numberWithInt:STATE_JUMP2]];
			break;
		case STATE_JUMP3:
			[jump3mgr setVisible:YES];
			[self doJump3FromPoint:p];
			[hud setState:[NSNumber numberWithInt:STATE_JUMP3]];
			break;
		case STATE_HANG:
			[hangmgr setVisible:YES];
			[self doHangFromPoint:p];
			break;
		case STATE_FALLING:
			//[fallmgr setVisible:YES];
			[self doFallFromPoint:p];
			break;
		case STATE_DYING:
			[death setDisplayFrame:@"death" index:0];
			[death setDisplayFrame:@"deathfall" index:0];
			
			[self doDeathFromPoint:p];
			//[deathmgr setVisible:YES];
			//[death setVisible:YES];
			break;
		default:
			break;
	}


	
	
}

#pragma mark collision position setters
-(void)terrainCollision:(CGPoint)point{
	//startpoint = point
	
	
	if(current_state == STATE_RUNNNING){
		// we are already running- dont reinitiate it
		run.position = ccp(point.x-16.0f,point.y);
		charbounds.origin.x = point.x;
		charbounds.origin.y = point.y;
		
	}
	
	else if(current_state != STATE_JUMP1
			&& current_state != STATE_JUMP2
			&& current_state != STATE_JUMP3 
			&& current_state != STATE_DYING){	
		
		[self switchStates:STATE_RUNNNING point:point];
		[sfx playSound:@"Landing1" atPosition:abspos];
	}
}

-(void)terrainCollisionEnded:(CGPoint)point{
	if(current_state == STATE_RUNNNING){
		[sfx stopLoops];
		[self switchStates:STATE_FALLING point:ccp(point.x,point.y)];
	}
	
	
}

#pragma mark touch actions 

- (BOOL)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	touches_down = NO;
	

		
	return kEventHandled;
}

- (BOOL)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {

	touches_down = YES;
	
	if(!isTouchEnabled){
		return kEventHandled;
	}
	switch (current_state) {
		case STATE_RUNNNING:
			[self switchStates:STATE_JUMP1 point:ccp(charbounds.origin.x,charbounds.origin.y)];
			break;
			// new stuff - ben
		case STATE_JUMP1:
			[self switchStates:STATE_JUMP2 point:ccp(charbounds.origin.x,charbounds.origin.y)];
			break;
			
		case STATE_JUMP2:
			[self switchStates:STATE_JUMP3 point:ccp(charbounds.origin.x,charbounds.origin.y)];
			break;
			// end new stuff
		case STATE_HANG:
			if(last_state == STATE_JUMP1){
				[self switchStates:STATE_JUMP2 point:ccp(charbounds.origin.x,charbounds.origin.y)];
			}else if(last_state == STATE_JUMP2){
				[self switchStates:STATE_JUMP3 point:ccp(charbounds.origin.x,charbounds.origin.y)];
			}
			else if(last_state == STATE_RUNNNING){
				[self switchStates:STATE_JUMP1 point:ccp(charbounds.origin.x,charbounds.origin.y)];
			}
			
			break;
		case STATE_FALLING:
			if(last_state == STATE_JUMP1){
				[self switchStates:STATE_JUMP2 point:ccp(charbounds.origin.x,charbounds.origin.y)];
			}else if(last_state == STATE_JUMP2){
				[self switchStates:STATE_JUMP3 point:ccp(charbounds.origin.x,charbounds.origin.y)];
			}
			else if(last_state == STATE_RUNNNING){
				[self switchStates:STATE_JUMP1 point:ccp(charbounds.origin.x,charbounds.origin.y)];
			}
			
			break;
			
		default:
			break;
	}
	
	return kEventHandled;
}


-(void) doJump1FromPoint: (CGPoint) point{
	hangtime = 0.0f;
	//[hud setHangLevel:[NSNumber numberWithFloat:1.0]];
	
	// set charbounds to the first frame
	
	jump1Up.transformAnchor = ccp(0,0);
	jump1Up.position = ccp(point.x-30,point.y-10);
	
	// here is where we need to override 
	
	[jump1Up runAction: jump1_seq ];
	[sfx playSound:@"Jump1" atPosition:abspos];
	
}


-(void) doJump2FromPoint: (CGPoint) point{
	hangtime = 0.0f;
	//[hud setHangLevel:[NSNumber numberWithFloat:1.0]];
	
	CGSize s = [[Director sharedDirector] winSize];
	jump2Up.transformAnchor = ccp(0,0);

	jump2Up.position = ccp(point.x- 36, point.y-10);
	
	
	// here is where we need to override 

	
	[jump2Up runAction:jump2_seq];
	[sfx playSound:@"Jump2" atPosition:abspos];
	
	
}


-(void) doJump3FromPoint: (CGPoint) point{
	hangtime = 0.0f;
	//[hud setHangLevel:[NSNumber numberWithFloat:1.0]];
	
	CGSize s = [[Director sharedDirector] winSize];
	jump3Up.transformAnchor = ccp(0,0);
	//jump3Up.position = point;
	jump3Up.position = ccp(point.x -42, point.y-10);
	
	// here is where we need to override 

	
	[jump3Up runAction:jump3_seq];
	[sfx playSound:@"Jump3" atPosition:abspos];
	
	
}







-(void) doHangFromPoint: (CGPoint) point{	
	
	
	
	CGSize s = [[Director sharedDirector] winSize];
	//hang.transformAnchor = ccp(frame1bound.origin.x,frame1bound.origin.y);
	hang.transformAnchor = ccp(0,0);
	if(last_state == STATE_JUMP3){
		hang.position = ccp(point.x-2, point.y-20);
		charbounds.origin.x = point.x +16;
		charbounds.origin.y = point.y;
	}else if(last_state == STATE_JUMP1){
		hang.position = ccp(point.x-25,point.y-4);

		charbounds.origin.x = point.x-3;
		charbounds.origin.y = point.y +4;
	}
	else { //jump 2
		hang.position = ccp(point.x-23,point.y-11);
		//hang.position = ccp(point.x, point.y);
		charbounds.origin.x = point.x;
		charbounds.origin.y = point.y;
		
	}


	
	charbounds.size.width = 30.0;
	charbounds.size.height = 45.0;

	[hang runAction: hang_action_repeater];
	
	
	
}

-(void) hangMeterChecker: (ccTime) dt
{
	if(touches_down && current_state == STATE_HANG){
		hangtime+=dt;
		//[hud setHangLevel:[NSNumber numberWithFloat:(1 - (hangtime/0.5f))]];
		if(hangtime > 0.5f){
			// time to come down
			current_state = last_state;
			[jumpaSpriteMgr removeAllChildrenWithCleanup:YES];
			[self remove:jumpaSpriteMgr];
			CGPoint fallpoint = CGPointMake(charbounds.origin.x, charbounds.origin.y);
			[self switchStates:STATE_FALLING point:fallpoint];
			hangtime = 0.0f;
			//[hud setHangLevel:[NSNumber numberWithFloat:1.0]];
		}
	}else{
		hangtime = 0.0f;
		//[hud setHangLevel:[NSNumber numberWithFloat:1.0]];
			[self stopAction:hang_waiter];
			if(current_state != STATE_FALLING){
				if(current_state == STATE_HANG){
					[self runAction:hang_waiter];
				}
			}
		}
		
		
		
		
			

		
		

}



-(void) doFallFromPoint: (CGPoint) point{ 
	[hangmgr setVisible:YES];
	CGSize s = [[Director sharedDirector] winSize];
	fall.transformAnchor = ccp(0,0);
	
	
	[hang setPosition:ccp(point.x-20.0f, point.y-17 )];
	fall.position = ccp(point.x-20.0f, point.y-17);

	
	// need to fall 45 pixels per 0.05seconds
	// so need to figure out the duration it would take to fall back to origin
	float distance = point.y + 100;
	float time_to_take = (distance/23)*0.05;

	
	[fall_transition setDuration:time_to_take];


	//id move_ease_in = [EaseInOut actionWithAction:fall_transition rate:2.0f];

	id move_ease_in = fall_transition;
	
	// "finished jumping" happens when we've fallen
	id seq2 = [Sequence actions:
			  // fall_hang_delay,
			  // fall_commence,
			   move_ease_in,
			   nil];	
	
	// but falling happens at the same time as the animation
	id conc = [Spawn actions:
			   fall_seq1,
			   seq2,
			   nil];
	
	[fall runAction:conc];
	
	
}

-(void)fallingCommenced
{
	//[sfx playSound:@"Fall2" atPosition:abspos];
}

-(void)revealJumpa{

	
	[hangmgr setVisible:NO];
	[fallmgr setVisible:YES];
	
}

-(void)revealDeath{
	[deathmgr setVisible:YES];
}

#pragma mark death sequences 

-(void) doDeathFromPoint: (CGPoint) point{

	CGSize s = [[Director sharedDirector] winSize];
	
	death.transformAnchor = ccp(0,0);
	death.position = ccp(point.x, point.y);
		
	// need to fall 45 pixels per 0.05seconds
	// so need to figure out the duration it would take to fall back to origin
	float distance = point.y - (-100.0f);
	float time_to_take = (distance/20)*0.05;
	
	
	[death_falling_transition setDuration:time_to_take];


	id DeathFade = [CallFunc actionWithTarget:self selector:@selector(deathfade)];
	// when death is over
	
	id fallAndArmsUp = [Spawn actions:death_fall_animation, death_falling_transition, nil];

	
//	death_seq = [[Sequence actions:
//				  [DelayTime actionWithDuration:0.01f],
//				  [CallFunc actionWithTarget:self selector:@selector(revealDeath)],
//				  death_action,
//				  death_blood_on,
//				  DeathFade,
//				  [DelayTime actionWithDuration:0.7f],
//				  death_fall_animation,
//				  death_falling_transition,
//				  death_finished,
//				  nil] retain];	

	death_seq = [[Sequence actions:
				  [DelayTime actionWithDuration:0.01f],
				  [CallFunc actionWithTarget:self selector:@selector(revealDeath)],
				  death_action,
				  death_blood_on,
				  DeathFade,
				  [DelayTime actionWithDuration:0.7f],
				  fallAndArmsUp,
				  death_finished,
				  nil] retain];	

	[self deathBloodOn];
	[death runAction:death_seq];
	[sfx playSound:@"Die_MusicEnd" atPosition:self.position];
	
}

					
-(void)deathfade{
	//NSLog(@"deathfade!!!");
	[[NSNotificationCenter defaultCenter] postNotificationName:@"deathfade" object:self];
}
					
-(void)finishedDeath{
	livesCount -= 1;
	[be setVisible:NO];

	if(livesCount > 0){
		[[NSNotificationCenter defaultCenter] postNotificationName:@"jumpaCharacterDidDie" object:self];
		//[self resetCreditsCounter];
		[self updateLivesCount];
	}else{
		[[NSNotificationCenter defaultCenter] postNotificationName:@"gameOver" object:self];
		[self resetCreditsCounter];
		livesCount = INITIAL_LIVES_COUNT;
		[self updateLivesCount];
		
	}
	
}

-(void)resetLivesCounter{
	livesCount = INITIAL_LIVES_COUNT;
}

-(void)deathBloodOn{
	//[be setVisible: YES];
}


-(void)finishedJump{
	CGPoint hangpoint = CGPointMake(charbounds.origin.x,charbounds.origin.y);
	
	[self switchStates:STATE_HANG point:hangpoint];
	
}

-(void)finishHang{
	//NSLog(@"hang over");
	[self switchStates:STATE_FALLING point:ccp(charbounds.origin.x, charbounds.origin.y)];
	
	
}

-(void)finishedJump1Fall{
}



-(void) doRunFromPoint:(CGPoint) point {
	CGSize s = [[Director sharedDirector] winSize];
	run.transformAnchor = ccp(0,0); 
	
	
	run.position = ccp(point.x-16.0f,point.y-15.0f);

	charbounds.origin.x = point.x;
	charbounds.origin.y = point.y;
	
	landingSprite.position = ccp(point.x -10, point.y);
	[landingSprite setVisible:YES];
	
	[run runAction:land_seq];
	
	
}

-(void)runningLoop{
	[runmgr setVisible:YES];
	[landingSprite setVisible:NO];
	[run runAction: run_loop_action ];
	[sfx playLoop:@"Run"];
}

#pragma mark responses to other things 
-(void) addCreditToScore
{
	creditsCount += 5;
	NSString *creditsStr = [NSString stringWithFormat:@"%d", creditsCount];
	
	[[UIApplication sharedApplication].delegate setGameScore:[NSNumber numberWithInt:creditsCount]];
	
	
	[hud setCreditsLabel:creditsStr];
	//[sfx playSound:@"credit" atPosition:abspos];
	[sfx credit];
}

-(void)resetCreditsCounter
{
	creditsCount = 0;
	[hud setCreditsLabel:@"0"];
}

-(int)getCreditsCounter
{
	return creditsCount;
}



-(void)updateLivesCount
{
	NSString *livesStr = [NSString stringWithFormat:@"%d", livesCount];
	[hud setLivesLabel:livesStr];
}

-(int)getLivesCounter{
	return livesCount;
}



#pragma mark drawing update routines 
-(void) draw{
	////NSLog(@"%d", current_state);

	glColor4f(1.0f, 1.0f, 1.0f, 1.0f);
	

	if(current_state == STATE_JUMP1){
		NSValue *bounds  = [jump1Up displayFrameBounds];
	
		if(bounds != nil){
			charbounds = [bounds CGRectValue];
			charbounds.origin.x += current_point.x -30;
			charbounds.origin.y += current_point.y -10;
		}
	}
	else if(current_state == STATE_JUMP2){
		NSValue *bounds  = [jump2Up displayFrameBounds];
		if(bounds != nil){
			charbounds = [bounds CGRectValue];
			charbounds.origin.x += current_point.x-36;
			//charbounds.origin.x += current_point.x;
			charbounds.origin.y += current_point.y-10;
		}
	}
	else if(current_state == STATE_JUMP3){
		NSValue *bounds  = [jump3Up displayFrameBounds];
		if(bounds != nil){
			charbounds = [bounds CGRectValue];
			charbounds.origin.x += current_point.x - 39;
			charbounds.origin.y += current_point.y-10;
		}
	}
	else if(current_state == STATE_RUNNNING){
		charbounds.size.width = 30.0f;
		charbounds.size.height = 64.0f;
		charbounds.origin.x = current_point.x;
		//charbounds.origin.y = current_point.y-15;
		charbounds.origin.y = current_point.y;

		
	}else if(current_state == STATE_FALLING){ // we are falling
		CGPoint foopoint = [fall position];
		charbounds.origin.x = foopoint.x + 20.0f;
		charbounds.origin.y = foopoint.y-5.0f;
		charbounds.size.height = 40.0f;
		charbounds.size.width = 30.0f;

		
	}else if(current_state == STATE_DYING){ // we are falling
		CGPoint foopoint = [death position];
		charbounds.origin.x = foopoint.x;
		charbounds.origin.y = foopoint.y;
		[be setPosition:ccp(charbounds.origin.x+10,charbounds.origin.y+50)];
		
		
	}
	

	abspos = [self convertToWorldSpace:CGPointZero];
	////NSLog(@"%f", abspos.y);
	absoluteBounds = CGRectMake(abspos.x + charbounds.origin.x, abspos.y+charbounds.origin.y, charbounds.size.width, charbounds.size.height);
	
	////NSLog(@"absoluteBounds = (x,y,w,h) = (%f,%f,%f,%f)", absoluteBounds.origin.x, absoluteBounds.origin.y, absoluteBounds.size.width, absoluteBounds.size.height);
	
	
	

}


-(void)updateBounds{
//	CGPoint layer_abspos =  [self absolutePosition];
//	abspos = ccp(charbounds.origin.x + layer_abspos.x, charbounds.origin.y + layer_abspos.y);
//
//	absoluteBounds = CGRectMake(abspos.x,abspos.y,charbounds.size.width,charbounds.size.height);
}


- (void) setOpacity: (GLubyte)newOpacity
{
	[jump1Up setOpacity:newOpacity];
	[fall setOpacity:newOpacity];
	[death setOpacity:newOpacity];
	[jump2Up setOpacity:newOpacity];
	[jump3Up setOpacity:newOpacity];
	[hang setOpacity:newOpacity];
	[run setOpacity:newOpacity];
	
}



@end

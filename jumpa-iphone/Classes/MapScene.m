//
//  MenuScene.m
//  Untitled
//
//  Created by Harry Potter on 2/07/09.
//  Copyright Synthesia 2009. All rights reserved.
//


#import "MapScene.h"



@implementation MapScene
- (id) init {
	
	self = [super init];
	
	if (self != nil) {
		ColorLayer *bgcol = [ColorLayer layerWithColor:35 width:1024 height: 768];
		[bgcol setRGB:128:255:0];
		bgcol.transformAnchor = ccp(0, 0);
		bgcol.position= ccp(-544.0, 0);
		[self addChild:bgcol z:1];
		ml = [[MapLayer node] retain];
        [self addChild:ml z:2];
		[ml setIsTouchEnabled:YES];
    }
	
    return self;
}

-(void)show{
	[ml show];
}

@end

@implementation MapLayer
- (id) init {
	NSLog(@"maplayer : init");
    self = [super init];
	
    if (self != nil) {
		
		//		if(![[[UIApplication sharedApplication] delegate] isIpad]){
		//			splash = [MenuItemImage itemFromNormalImage:@"splash1.png" selectedImage:@"splash2.png" target:self selector:@selector(startGame:)];
		//			splash.position = CGPointZero;
		//		}else{
		//			splash = [MenuItemImage itemFromNormalImage:@"hd_splash1.png" selectedImage:@"hd_splash2.png" target:self selector:@selector(startGame:)];
		//			splash.position = ccp(-544,0);
		//		}
		
		
		
		
		complete = [[Sprite node] retain];
		mask_fadeout = [[FadeOut actionWithDuration:0.3]retain];
		
		
		Sprite *stars_bg = [Sprite spriteWithFile:@"scrolling_stars_bg.png"];
		stars_bg.transformAnchor = ccp(0,0);
		stars_bg.position = ccp(-544,0);
		[self addChild:stars_bg];
		
		stars_scrolling = [[Sprite spriteWithFile:@"scrolling_stars.png"] retain];
		stars_scrolling.transformAnchor = ccp(0,0);
		stars_scrolling.position = ccp(-544,0);
		[self addChild:stars_scrolling];
		stars_scrolling2 = [[Sprite spriteWithFile:@"scrolling_stars.png"] retain];
		stars_scrolling2.transformAnchor = ccp(0,0);
		stars_scrolling2.position = ccp(480,0);
		[self addChild:stars_scrolling2];
		
		id star_movement_1 = [MoveTo actionWithDuration:50.0f position:ccp(-1568,0)];
		id star_movement_2 = [MoveTo actionWithDuration:50.0f position:ccp(-544,0)];
		id star_refresh_1 = [CallFunc actionWithTarget:self selector:@selector(scrollingStarsReset1)];
		id star_refresh_2 = [CallFunc actionWithTarget:self selector:@selector(scrollingStarsReset2)];
		id star_seq_1 = [Sequence actions:star_movement_1, star_refresh_1, nil];
		id star_seq_2 = [Sequence actions:star_movement_2, star_refresh_2, nil];
		
		[stars_scrolling runAction:[RepeatForever actionWithAction:star_seq_1]];
		[stars_scrolling2 runAction:[RepeatForever actionWithAction:star_seq_2]];
		
		
		masklevel = 1;
		splash = [Sprite spriteWithFile:@"map_hd_frame1.png"];
		splash.transformAnchor = ccp(0,0);
		splash.position = ccp(-544.0,0);
		
		[complete addChild:splash];
		
		mask1 = [[Sprite spriteWithFile:@"map_mask_1_hd.png"] retain];
		mask1.transformAnchor = ccp(0,0);
		mask1.position = ccp(-544.0,0);
		
		[complete addChild:mask1];
		
		mask2 = [[Sprite spriteWithFile:@"map_mask_2_hd.png"] retain];
		mask2.transformAnchor = ccp(0,0);
		mask2.position = ccp(-544.0,0);
		
		[complete addChild:mask2];
		
		mask3 = [[Sprite spriteWithFile:@"map_mask_3_hd.png"] retain];
		mask3.transformAnchor = ccp(0,0);
		mask3.position = ccp(-544.0,0);
		
		[complete addChild:mask3];
		
	
		// other transitions
		
		Animation *foo = [Animation animationWithName:@"map" delay:0.5];
		[foo addFrame:@"map_hd_frame1.png"];
		[foo addFrame:@"map_hd_frame2.png"];
		
		id ani = [Animate actionWithAnimation:foo];
		id rep = [RepeatForever actionWithAction:ani];
		[splash runAction:rep];
		
		[self addChild:complete];
		

		
		fader_blackness = [[Sprite spriteWithFile:@"blackness.png"] retain];
		fader_blackness.transformAnchor = ccp(0,0);
		[fader_blackness setScale:20.0f];
		[fader_blackness setPosition:ccp(-900, -200)];
		[self addChild:fader_blackness];
		
		fadeout_action = [[FadeOut actionWithDuration:6.0f] retain];
		fadein_action = [[FadeIn actionWithDuration:1.7f] retain];
	
		id seq_startgame_delay = [[DelayTime actionWithDuration:0.4f] retain];
		id rungame = [[CallFunc actionWithTarget:self selector:@selector(runGame)] retain];
		id delay1 = [[DelayTime actionWithDuration:1.0f] retain];
		id showLevel1Start = [[CallFunc actionWithTarget:self selector:@selector(showLevelStartSprites)] retain];
		id level1start_delay = [[DelayTime actionWithDuration:1.0f] retain];
		id showLevel1Start_seq = [[Sequence actions:level1start_delay, showLevel1Start,nil] retain];
		id delay2 = [[DelayTime actionWithDuration:1.0f] retain];
		id startSound = [[CallFunc actionWithTarget:self selector:@selector(startGameMusic)] retain];
		id spawn_startgame = [[Spawn actions:fadein_action, fadeout_sound, showLevel1Start_seq, nil] retain];

	
		//seq_startgame = [[Sequence actions:seq_startgame_delay, spawn_startgame, delay1, startSound, delay2, rungame, nil] retain];
		seq_startgame = [[Sequence actions:seq_startgame_delay, spawn_startgame, delay1, startSound, rungame, nil] retain];
		
	
		
		level1 = [[Sprite spriteWithFile:@"level_1_hd.png"] retain];
		level1.transformAnchor = ccp(0,0);
		//level1.position = ccp(-300,550);
		level1.position = ccp(-554-575,550);
		[self addChild:level1];

		level1_start = [[Sprite spriteWithFile:@"level_start_hd.png"] retain];
		level1_start.transformAnchor = ccp(0,0);
		//level1_start.position = ccp(304-554,400);
		level1_start.position = ccp(480,400);
		
		[self addChild:level1_start];
		
	}
	
    return self;
	
	
}


-(void)show{
	[fader_blackness runAction:fadeout_action];
	RCMusicItem *mapMusic = [[RCMusicManager sharedMusicManager] getMusicItemWithName:@"map"];
	//[mapMusic play];
	
	
}

-(void)scrollingStarsReset1{
	stars_scrolling.position = ccp(-544,0);
}

-(void)scrollingStarsReset2{
	stars_scrolling2.position = ccp(480,0);
}


-(void)fadeMask:(Sprite *)maskSprite{
	[maskSprite stopAllActions];
	[maskSprite runAction:mask_fadeout];
}


- (BOOL)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	NSLog(@"mapscene : touches ended");
	[[SFXManager sharedSoundManager] playSound:@"menutouch" atPosition:CGPointZero];
	
	
	
	id scale = [ScaleTo actionWithDuration:2.0f scale:2.3f];
	id move = [MoveTo actionWithDuration:2.0f position:ccp(800.0f, -600.0f)];
	
	id spawn = [Spawn actions:scale, move,nil];
	
	
	
	[complete runAction:spawn];
	[fader_blackness runAction:seq_startgame];
	

	
	
	
	//	switch (masklevel) {
	//		case 1:
	//			[self fadeMask:mask1];
	//			break;
	//		case 2:
	//			[self fadeMask:mask2];
	//			break;
	//		case 3:
	//			[self fadeMask:mask3];
	//			break;
	//		case 4:
	//			[mask3 setOpacity:255];
	//			[mask2 setOpacity:255];
	//			[mask1 setOpacity:255];
	//			masklevel = 0;
	//		default:
	//			break;
	//	}
	//	masklevel++;
	
	return kEventHandled;
}

-(void)runGame{
	id gs = [[[UIApplication sharedApplication] delegate] getSharedGameScene];
	[gs startGame];
	[[Director sharedDirector] replaceScene:gs];
	
	
}

-(void)startGameMusic{
	NSLog(@"START GAME MUSIC");
	RCMusicItem *level1Music = [[RCMusicManager sharedMusicManager] getMusicItemWithName:@"level1"];
	[level1Music play];
	[level1Music setVolume:[NSNumber numberWithFloat:0.0f]];

}

-(void)showLevelStartSprites{
	id frame0_7= [MoveTo actionWithDuration:0.36 position:ccp(-270,550)];
	id frame8_9= [MoveTo actionWithDuration:0.08 position:ccp(-300,550)];
	id seq = [Sequence actions: frame0_7,frame8_9 ,nil];
	
	id start_frame0_7= [MoveTo actionWithDuration:0.36 position:ccp(274-554,400)];
	id start_frame8_9= [MoveTo actionWithDuration:0.08 position:ccp(304-554,400)];
	id seq2 = [Sequence actions:start_frame0_7, start_frame8_9, nil];
	
	
	[level1 runAction:seq];
	[level1_start runAction:seq2];
	
}

-(void)startGame: (id)sender {

}

-(void)switchToGameScene: (id)sender {
	
	
	
}


-(void)help: (id)sender {
    //NSLog(@"help");
}
@end

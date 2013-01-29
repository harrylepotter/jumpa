//
//  LevelFinishedScene.m
//  jumpa
//
//  Created by harry on 10/03/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "LevelFinishedScene.h"
#import "LevelSelectScene.h"
#import "GameScene.h"
#import "constants.h"
#import "SFXManager.h"



@implementation LevelFinishedScene
-(id) initWithCreditsScore:(int)creditsamt livesScore:(int)livesScore
{
	//NSLog(@"LevelFinishedScene : init");
	if( ![super init] )
		return nil;
	LevelFinishedLayer *levelfinishedCharacter = [[LevelFinishedLayer alloc] initWithCreditsScore:creditsamt livesScore:livesScore];
	[self addChild:levelfinishedCharacter];
	
	

	return self;
}


@end

@implementation LevelFinishedLayer
-(id) initWithCreditsScore:(int)creditsamt livesScore:(int)livesScore
{
	if( ![super init] )
		return nil;
	
	show_unlocked_sprite = NO;
	show_heart_unlocked_sprite = NO;
	
	
	maxScore = [[UIApplication sharedApplication].delegate getMaximumPossibleScore];
	
	creditsCount = 0;

	
	livesVal = livesScore;
	credits = creditsamt;
	initialNumCredits = creditsamt;
	voidNode = [[Sprite node] retain];
	voidNode.transformAnchor = ccp(0,0);
	voidNode.position = ccp(70, 56);
	
	NSLog(@"credits: %d", creditsamt);
	NSLog(@"MAXIMUM POSSIBLE SCORE IS : %d", maxScore);
	
	heart_threshold_score =  /*(float)creditsamt -*/  (float)((float)maxScore*0.7f);
	
	NSString *current_level =  [[GameScene sharedGameScene] getLevelName];
	NSString *next_level;
	if([current_level isEqualToString:@"easy"]){
		next_level = @"medium";
	}else if([current_level isEqualToString:@"medium"]){
		next_level = @"hard";
	}else if([current_level isEqualToString:@"hard"]){
		next_level = @"extreme";
	}else{
		next_level = Nil;
	}

	NSLog(@"next level = %@", next_level);
	
	currentLevelBadge = [[self badgeForDifficulty:current_level] retain];
	if(next_level != Nil)
		nextLevelBadge = [[self badgeForDifficulty:next_level] retain];
	
	[currentLevelBadge setButtonState:STATE_UNLOCKED];
	[currentLevelBadge setPosition:ccp(290,210)];
	[self addChild:currentLevelBadge];
	
	if(nextLevelBadge != nil){
		[nextLevelBadge setButtonState:STATE_LOCKED];
		[nextLevelBadge setPosition:ccp(290, 130)];
		[self addChild:nextLevelBadge];
	}
		
	NSNumber *currentLevelUnlockState = [[[UIApplication sharedApplication].delegate getUnlockables] objectForKey:current_level];
	
	NSNumber *nextLevelUnlockState = Nil;
	if(next_level != Nil){
		nextLevelUnlockState = [[[UIApplication sharedApplication].delegate getUnlockables] objectForKey:next_level];
		[nextLevelBadge setButtonState:[nextLevelUnlockState intValue]];
		
		if([nextLevelUnlockState intValue] == STATE_UNLOCKED || [nextLevelUnlockState intValue] == STATE_UNLOCKED_WON){
			[nextLevelBadge setVisible:NO];
		}
		
	}
	
	[currentLevelBadge setButtonState:[currentLevelUnlockState intValue]];
	
	if([currentLevelUnlockState intValue] == STATE_UNLOCKED_WON){
		[currentLevelBadge setVisible:NO];
	}
	
	
	if(next_level != Nil  &&  nextLevelUnlockState != Nil && [nextLevelUnlockState intValue] == STATE_LOCKED){
		[[[UIApplication sharedApplication].delegate getUnlockables] setObject:[NSNumber numberWithInt:STATE_UNLOCKED] forKey:next_level];
		show_unlocked_sprite = YES;
	}
	
	[[UIApplication sharedApplication].delegate writeUnlockables];
	[[LevelSelectScene sharedLevelSelectScene] setLevelSelection];
	
	currentLevelUnlockState = [[[UIApplication sharedApplication].delegate getUnlockables] objectForKey:current_level];
	
	int lockstate = [currentLevelUnlockState intValue];
	
	
	if( ((lockstate == STATE_UNLOCKED) || (heart_threshold_score > 0)) && (lockstate != STATE_UNLOCKED_WON)){
		show_heart_unlocked_sprite = YES;
	}
	
	Sprite *bg = [Sprite spriteWithFile:@"levelfinished_bg.png"];
	bg.position = ccp(0,69);
	bg.transformAnchor = ccp(0,0);
	[self addChild:bg];
	
	
	[self addChild:voidNode];

	runmgr = [[AtlasSpriteManager spriteManagerWithFile:@"run.png" capacity:50] retain];
	[voidNode addChild:runmgr z:10 tag:1];
	
	run = [[AtlasSprite spriteWithRect:CGRectMake(0, 0, 64, 74) spriteManager: runmgr] retain];
	[runmgr addChild:run];
	AtlasAnimation *runanim = [[AtlasAnimation animationWithName:@"run" delay:0.06f] retain];
	
	for(int i=0;i<10;i++) {
		int x= i % 5;
		int y= i / 5;
		[runanim addFrameWithRect: CGRectMake(x*64, y*74, 64, 74) ];
	}
	
	run.transformAnchor = ccp(0,0);
	run.position = ccp(0, 0);
	[run setScale:1.0f];
	[run setOpacity:0];
	
	run_action = [[Animate actionWithAnimation: runanim] retain];
	run_loop_action = [[RepeatForever actionWithAction:run_action] retain];
	move_to = [[MoveTo actionWithDuration:2.0f position:ccp(190,30)] retain];
	id fadein = [[FadeIn actionWithDuration:2.0f] retain];
	id finished_fade_in = [[CallFunc actionWithTarget:self selector:@selector(finishedFadeIn)] retain];
	[run runAction:[Spawn actions: fadein, finished_fade_in, nil]];
	
	[[SFXManager sharedSoundManager] stopLoops];
	
	
	
		/*********** CREDITS SLIDER *******/
	CocosNode *creditsNode = [CocosNode node];
	[creditsNode setTransformAnchor:ccp(0,0)];
	[creditsNode setPosition:ccp(0,0)];
	Sprite *creditsBorder = [Sprite spriteWithFile:@"summary_2.png"];
	creditsBorder.transformAnchor = ccp(0,0);
	creditsBorder.position = ccp(-141,165);
	[creditsNode addChild:creditsBorder];
	creditLabel = [LabelAtlas labelAtlasWithString:[NSString stringWithFormat:@"%d", credits] charMapFile:@"tuffy_bold_italic-charmap.png" itemWidth:48 itemHeight:64 startCharMap:' '];
	[creditLabel setScale:0.24];
	[creditLabel setTransformAnchor:ccp(0,0)];
	[creditLabel setPosition:ccp(-111, 168)];
	[creditsNode addChild:creditLabel];
	creditsMgr = [[AtlasSpriteManager spriteManagerWithFile:@"PickupCredits.png" capacity:8] retain];
	creditsSymbol = [[AtlasSprite spriteWithRect:CGRectMake(0, 0, 32, 32) spriteManager: creditsMgr] retain];
	creditsAnimation = [[AtlasAnimation animationWithName:@"credit" delay:0.05f] retain];
	
	for(int i=0;i<7;i++) {
		[creditsAnimation addFrameWithRect: CGRectMake(i*32, 0, 32, 32) ];
	}
	
	[creditsMgr addChild:creditsSymbol];
	creditsSymbol.transformAnchor = ccp(0,0);
	creditsSymbol.position = ccp(-139,162);
	[creditsSymbol setScale:0.75f];
	creditsAnimationAction = [[Animate actionWithAnimation: creditsAnimation] retain];

	[creditsNode addChild:creditsMgr];
	[creditsNode runAction:[self creditSlideIn:creditsNode.position]];
	[self addChild:creditsNode];

	creditMeter = [[[creditMeterLayer alloc] init] retain];
	[self addChild:creditMeter];
	
	
	
	
	
	levelUnlockedLabel  = [LabelAtlas labelAtlasWithString:@"LEVEL UNLOCKED" charMapFile:@"tuffy_bold_italic-charmap.png" itemWidth:48 itemHeight:64 startCharMap:' '];
	[levelUnlockedLabel setScale:0.3f];
	levelUnlockedLabel.position = ccp(240, 150);
	[levelUnlockedLabel setVisible:NO];
	[self addChild:levelUnlockedLabel];

	heartUnlockedLabel  = [LabelAtlas labelAtlasWithString:@"HEART UNLOCKED" charMapFile:@"tuffy_bold_italic-charmap.png" itemWidth:48 itemHeight:64 startCharMap:' '];
	[heartUnlockedLabel setScale:0.3f];
	heartUnlockedLabel.position = ccp(240, 230);
	[self addChild:heartUnlockedLabel];
	[heartUnlockedLabel setVisible:NO];
	
	
	
	
	return self;
	
}
	

	 

-(void)finishedFadeIn{
	[run runAction:run_loop_action];
}

-(void)startDecrementingCredits{
	//NSLog(@"start decrementing");
	id decrementa = [[DelayTime actionWithDuration:0.04] retain];
	id goAgaina = [[CallFunc actionWithTarget:self selector:@selector(decrementCredits)] retain];
	id seq = [Sequence actions:decrementa, goAgaina,nil];
	id repeata = [RepeatForever actionWithAction:seq];
	[creditLabel stopAllActions];
	[creditLabel runAction:repeata];
	[creditsSymbol runAction: [RepeatForever actionWithAction:creditsAnimationAction ] ];
}

-(void)decrementCredits{
	
	if(credits >= 0){
		
		
		
		
		if(((float)credits < (maxScore - heart_threshold_score)) && (initialNumCredits >= heart_threshold_score) && show_heart_unlocked_sprite){
			
			NSLog(@"WIN...");
			show_heart_unlocked_sprite = NO;
			id blink = [Blink actionWithDuration:50.0f blinks:100];
			[currentLevelBadge runAction:blink];
			[currentLevelBadge setButtonState:STATE_UNLOCKED_WON];
			[[[UIApplication sharedApplication].delegate getUnlockables] setObject:[NSNumber numberWithInt:STATE_UNLOCKED_WON] forKey:[[GameScene sharedGameScene] getLevelName]];
			[heartUnlockedLabel setVisible:YES];
			
		}
		
		
		[creditLabel setString:[NSString stringWithFormat:@"%d", credits]];
		if(credits % 20 == 0){
			credits = credits -20;
			creditsCount = creditsCount +20;
		}else{
			credits = credits - 5;
			creditsCount = creditsCount + 5;
		}
		
			
		[[SFXManager sharedSoundManager] credit];
		float percent = (((float)creditsCount)/(((float)maxScore)*0.8f));
		[creditMeter setCreditsPercentage:[NSNumber numberWithFloat:percent]];
	
		//if(credits % 30 == 0)
			//[self addStarEmitter:ccp(132,175)];
		
	}else{
		
		if(show_unlocked_sprite){
			id blink = [Blink actionWithDuration:50.0f blinks:100];
			[nextLevelBadge runAction:blink];
			[nextLevelBadge setButtonState:STATE_UNLOCKED];
			show_unlocked_sprite = NO;
			[levelUnlockedLabel setVisible:YES];
		}
		
		
		[creditLabel stopAllActions];
		[creditsSymbol stopAllActions];

		MenuItemImage *item1 = [MenuItemImage itemFromNormalImage:@"NextButtonOff.png" selectedImage:@"NextButtonOn.png" target:self selector:@selector(selectedBackForwardMenuItem:)];
        Menu *menu = [Menu menuWithItems:item1, nil];
        menu.position = CGPointZero;
        item1.position = ccp(400,30);
		
		[self addChild:menu];

		
		
	}
	
}

	 
	
	 
	 
	 
- (void)selectedBackForwardMenuItem:(id)sender {
	[[SFXManager sharedSoundManager] playSound:@"menutouch" atPosition:CGPointZero];
	RCMusicItem *gameMusic = [[RCMusicManager sharedMusicManager] getMusicItemWithName:@"level1"];
	[gameMusic stop];
	
	NSString *current_level =  [[GameScene sharedGameScene] getLevelName];
	if([current_level isEqualToString:@"extreme"]){
		RCMusicItem *gameMusic = [[RCMusicManager sharedMusicManager] getMusicItemWithName:@"level1"];
		[gameMusic stop];
		MPMoviePlayerController *mMoviePlayer;
		NSBundle *bundle = [NSBundle mainBundle];
		NSString *moviePath = [bundle pathForResource:@"EndCredits" ofType:@"m4v"];
		mMoviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:[NSURL fileURLWithPath:moviePath]];
		
		// Register to receive a notification when the movie has finished playing. 
		[[NSNotificationCenter defaultCenter] addObserver:self 
												 selector:@selector(moviePlayBackDidFinish:) 
													 name:MPMoviePlayerPlaybackDidFinishNotification 
												   object:mMoviePlayer];
		
		
		
		[mMoviePlayer play];
	}else{
		RCMusicItem *level1Music = [[RCMusicManager sharedMusicManager] getMusicItemWithName:@"title"];
		[level1Music setVolume:[NSNumber numberWithFloat:1.0f]];
		[level1Music play];
		[[Director sharedDirector] replaceScene:[LevelSelectScene sharedLevelSelectScene]];
	}
	
		
	
	//[[[UIApplication sharedApplication] delegate] runMenuScene];
}

- (void) moviePlayBackDidFinish:(NSNotification*)notification
{
	RCMusicItem *level1Music = [[RCMusicManager sharedMusicManager] getMusicItemWithName:@"title"];
	[level1Music setVolume:[NSNumber numberWithFloat:1.0f]];
	[level1Music play];
	[[Director sharedDirector] replaceScene:[LevelSelectScene sharedLevelSelectScene]];
	
}

-(difficultymenuitem*)badgeForDifficulty:(NSString*)difficulty{
	if([difficulty isEqualToString:@"easy"]){
		return [[easymenuitem alloc] init];
	}else if([difficulty isEqualToString:@"medium"]){
		return [[mediummenuitem alloc] init];
	}else if([difficulty isEqualToString:@"hard"]){
		return [[hardmenuitem alloc] init];
	}else{
		return [[extememenuitem alloc] init];
	}
	
}

-(void)startDecrementingLives{
	//NSLog(@"start decrementing lives");
	id decrementa = [[DelayTime actionWithDuration:0.2] retain];
	id goAgaina = [[CallFunc actionWithTarget:self selector:@selector(decrementLives)] retain];
	id seq = [Sequence actions:decrementa, goAgaina,nil];
	id repeata = [RepeatForever actionWithAction:seq];
	[lifeLabel stopAllActions];
	[lifeLabel runAction:repeata];
}

-(void)decrementLives{
	//NSLog(@"decrement credits");
	if(livesVal >= 0){
		[lifeLabel setString:[NSString stringWithFormat:@"x%d", livesVal]];
		livesVal = livesVal -1;
		//[self addStarEmitter:ccp(132,256)];
	}else{
		[lifeLabel stopAllActions];
		[livesSymbol stopAllActions];
		[self startDecrementingCredits];
	}
	
}





-(id)bounceAction: (CGPoint)toPosition fromPosition:(CGPoint)fromPosition left:(BOOL)left
{
	//NSLog(@"bounceaction: to: %f,%f", toPosition.x, toPosition.y);
	float x_to = 0.0;toPosition.x + fromPosition.x / 16;
	float x_to_2 = 0.0;
	float x_to_3 = 0.0;
	x_to = toPosition.x - (fromPosition.x / 16);
	x_to_2 = toPosition.x + (fromPosition.x / 32);
	id move_to = [MoveTo actionWithDuration:0.25 position:ccp(x_to,toPosition.y)];
	id move_back = [MoveTo actionWithDuration:0.1 position:ccp(x_to_2,toPosition.y)];
	id move_back_agagain = [MoveTo actionWithDuration:0.05 position:toPosition];
	id seq = [Sequence actions: move_to,move_back,move_back_agagain, nil];
	return seq;
}

-(id)summaryBorderSlideIn: (CGPoint)fromPosition 
{
	//NSLog(@"summary border from %f, %f", fromPosition.x, fromPosition.y);
	
	id frame0_77 =  [DelayTime actionWithDuration:3.08];
	id frame77_83 = [MoveTo actionWithDuration:0.24 position:ccp(fromPosition.x + 219.75, fromPosition.y)];
	id frame83_85 = [MoveTo actionWithDuration:0.08 position:ccp(fromPosition.x + 217.5, fromPosition.y)];
	id seq = [Sequence actions: frame0_77,frame77_83,frame83_85, nil];
	return seq;	
}

-(id)lifeSlideIn: (CGPoint)fromPosition 
{
	//NSLog(@"summary border from %f, %f", fromPosition.x, fromPosition.y);
	
	id frame0_79 =  [DelayTime actionWithDuration:3.08];
	id frame79_85 = [MoveTo actionWithDuration:0.24 position:ccp(fromPosition.x + 228.0, fromPosition.y)];
	id frame85_87 = [MoveTo actionWithDuration:0.08 position:ccp(fromPosition.x + 222.7, fromPosition.y)];
	id someDelay = [DelayTime actionWithDuration:0.24];
	id finished = [CallFunc actionWithTarget:self selector:@selector(finishedLifeSlideIn)];
	
	id seq = [Sequence actions: frame0_79,frame79_85,frame85_87,someDelay,finished, nil];
	return seq;
	
}

-(void)finishedLifeSlideIn{
	[self startDecrementingCredits];
}
	
-(id)oxygenSlideIn: (CGPoint)fromPosition 
{
	id seq = [Sequence actions: [DelayTime actionWithDuration:0.08], [self lifeSlideIn:fromPosition], nil];
	return seq;
	
}

-(id)creditSlideIn: (CGPoint)fromPosition 
{
	id seq = [Sequence actions: [DelayTime actionWithDuration:0.16], [self lifeSlideIn:fromPosition], nil];
	return seq;
	
}

-(void)addStarEmitter:(CGPoint)location{
	//NSLog(@"adding star emitter at %f,%f", location.x, location.y);
	
	ParticleSystem *emitter = [bigParticleStar node];
	[emitter setPosition:location];
	emitter.texture = [[TextureMgr sharedTextureMgr] addImage: @"superstars.png"];
	[self addChild: emitter z:999];
	
}





@end
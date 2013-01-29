//
//  GameScene.m
//  Untitled
//
//  Created by Harry Potter on 2/07/09.
//  Copyright Synthesia 2009. All rights reserved.
//

#import "GameScene.h"
#import "MenuScene.h"
#import "BigMushroomEnemy.h"

int ticks = 0;


@implementation GameScene
@synthesize physics;

static GameScene *sharedGame = nil;

+ (GameScene*)sharedGameScene {
	@synchronized(self)	{
		if (!sharedGame){
			sharedGame = [[GameScene alloc] init];            
        }
		return sharedGame;
	}
	// to avoid compiler warning
	return nil;
}


- (id) init {
    self = [super init];
    if (self != nil) {
		
		
		level_finished = NO;
		paused = NO;
		spawn_point = ccp(0.0,0.0);
		
		
		// LOAD UP THE LEVEL
//		NSDictionary *level1Dictionary;



		
		

		jumpaAppDelegate *appDelegate = (jumpaAppDelegate *)[UIApplication sharedApplication].delegate;
		
		
		physics = [appDelegate jumpaCollisionPhysics];
		[physics setGameScene:self];
	
		
		
		//define parralaxable layers - voidnode
		
		// container node
		voidNode = [[CocosNode node] retain];
		soundNode = [[CocosNode node] retain];
		[self addChild:soundNode];
		backgroundNode = [[CocosNode node] retain]; 
		parralaxBackgrounds = [[backgroundLayer node]retain];

		[backgroundNode addChild:parralaxBackgrounds];
		[self addChild:backgroundNode];
		
		terrain = [[TerrainLayer node] retain];
		//Cave 

		caveBack = [[Sprite spriteWithFile:@"Cave0002.png"] retain];
		caveBack.transformAnchor = ccp(0.0, 0.0);
		//[caveBack setPosition:ccp(endpoint, -50.0)];

		blackness = [[Sprite spriteWithFile:@"blackness.png"] retain];
		blackness.transformAnchor = ccp(0.0, 0.0);
		[blackness setScale:50.0f];
		//[blackness setPosition:ccp(endpoint+500.0f, -300.0)];	

		caveFront = [[Sprite spriteWithFile:@"Cave0001.png"] retain];
		 caveFront.transformAnchor = ccp(0.0, 0.0);
	//	 [caveFront setPosition:ccp(endpoint, -50.0)];	
//		[physics setEndPoint:[NSNumber numberWithFloat:endpoint-200.0f]];
//		 
		enemiesLayer = [[EnemyLayer node] retain];
		credits = [[creditsLayer node] retain];
		
		
		
		// gaming layer - contains character
		gaminglayer = [[GameLayer node] retain];

		[voidNode addChild:caveBack z:1];
        [voidNode addChild:terrain z:2];
		[voidNode addChild:blackness z:3];
		[voidNode addChild:enemiesLayer z:4];
		[voidNode addChild:gaminglayer z:5];
		[voidNode addChild:credits z:6];
		[voidNode addChild:caveFront z:7];

		// add the jump meter
		jumpMeter = [[jumpMeterLayer node] retain];
		[gaminglayer setHud:jumpMeter];
		[self addChild:jumpMeter z:11];
		
		// associate the sound effects manager
		soundmgr = [[SFXManager sharedSoundManager] retain];
		[soundmgr addSound:@"menutouch" gain:[NSNumber numberWithFloat:0.9f] looped: NO];
		[gaminglayer setSfxManager:soundmgr];
		[gaminglayer initSfx];

		// add the container node to the scene 
		[self addChild:voidNode z:1];

		
		checkpointLayer = [[[CheckpointLayer alloc] init] retain];
		[self addChild:checkpointLayer];
		
		[checkpointLayer setSfxManager:soundmgr];
		
		fader_blackness = [[Sprite spriteWithFile:@"blackness.png"] retain];
		fader_blackness.transformAnchor = ccp(0,0);
		[fader_blackness setScale:100.0f];
		[fader_blackness setPosition:ccp(-1000, -200)];
	
		[voidNode addChild:fader_blackness z:998];
		
		[self setupEventObservers];
		
	
		
		// TODO: Replace
		RCMusicItem *level1_audio = [[[RCMusicManager sharedMusicManager] addMusicItemWithName:@"level1"] retain];

		music_bendDown = [[MusicFadeAction actionWithDuration:3.0f fadeTo:100.0f property:@"Frequency" musicItem:level1_audio] retain];

		music_bendUp = [[MusicFadeAction actionWithDuration:1.5f fadeTo:44100.0f property:@"Frequency" musicItem:level1_audio] retain];
		
		
		
#ifdef DEBUG_MODE
		
		Sprite *tempgrid = [Sprite spriteWithFile:@"Grid.png"];
		tempgrid.transformAnchor = ccp(0,0);
		[tempgrid setTransformAnchor:ccp(0,0)];
		[self addChild:tempgrid z:100];		
#endif
		
		
		
		// setup actions
		
		// game over fadeout
		sometime = [[DelayTime actionWithDuration:1.0f] retain];
		sometime2 = [[DelayTime actionWithDuration:4.0f] retain];
		fadeout = [[FadeIn actionWithDuration:0.25f] retain];
		restart_game = [[CallFunc actionWithTarget:self selector:@selector(restartLevel)] retain];
		end_game = [[CallFunc actionWithTarget:self selector:@selector(showGameOverScene)] retain];
		fadein = [[FadeOut actionWithDuration:0.5f] retain];
		//gameover_fadeout_seq = [[Sequence actions:fadein,end_game, nil] retain];


		
		// death fadeout
		sometime3 = [[DelayTime actionWithDuration:2.7f] retain];
		movementcallback = [[CallFunc actionWithTarget:self selector:@selector(restartLevel)] retain];
		//id fadeInSoundAndVideo = [[Spawn actions:music_bendUp, fadein, nil] retain];
		death_fadeout_seq = [[Sequence actions:sometime3,movementcallback, fadein, nil] retain];
		
		initial_fade_in = [[FadeOut actionWithDuration:2.0f] retain];
		[self setVisible:NO];
		[self setOpacity:0.0f];
		
		
		level1 = [[Sprite spriteWithFile:@"level_1_hd.png"] retain];
		level1.transformAnchor = ccp(0,0);
		level1.position = ccp(-300,550);
		
		[self addChild:level1 z:999];
		
		level1_start = [[Sprite spriteWithFile:@"level_start_hd.png"] retain];
		level1_start.transformAnchor = ccp(0,0);
		level1_start.position = ccp(304-554,400);
		[self addChild:level1_start z:999];
		
		id frame0 = [[DelayTime actionWithDuration:2.0f] retain];
		id frame0_7= [[MoveTo actionWithDuration:0.08 position:ccp(-270,550)] retain];
		id frame8_9= [[MoveTo actionWithDuration:0.36 position:ccp(-554-575,550)] retain];
		level1_seq = [[Sequence actions: frame0, frame0_7,frame8_9 ,nil] retain];
		
		id start_frame0_7= [[MoveTo actionWithDuration:0.08 position:ccp(274-554,400)] retain];
		id start_frame8_9= [[MoveTo actionWithDuration:0.36 position:ccp(480,400)] retain];
		start_seq = [[Sequence actions:frame0, start_frame0_7, start_frame8_9, nil] retain];
		

		
    }
	
	//[self schedule:@selector(step:) interval:1.0f/35.0f];
	
	level1Music = [[[RCMusicManager sharedMusicManager] getMusicItemWithName:@"level1"] retain];

    return self;
}

-(void)setLevel:(NSDictionary*)level name:(NSString*)name{
	
	levelname = [name retain];

	
	jumpaAppDelegate *appDelegate = (jumpaAppDelegate *)[UIApplication sharedApplication].delegate;
	NSString *bestScore = [NSString stringWithFormat:@"HI %d", [[appDelegate getTopScore] intValue]];
	[jumpMeter setBestScoreLabel:bestScore];
	
	[[oxyMeterLayer sharedOxyMeter] refresh];
	[appDelegate setGameScore:[NSNumber numberWithInt:0]];
	[gaminglayer resetCredits];


	NSArray *terrainsData = [[level objectForKey:@"terrains"] retain];
	level_width = [[level objectForKey:@"levelwidth"] floatValue];
	NSArray *enemiesData = [[level objectForKey:@"enemies"] retain];
	NSArray *creditsData = [[level objectForKey:@"credits"] retain];
	NSArray *oxygensData = [[level objectForKey:@"oxygens"] retain];
	NSArray *livesData = [[level objectForKey:@"lives"] retain];

	NSNumber *levelWidth = [level objectForKey:@"levelwidth"];
	float endpoint = [levelWidth floatValue] - 1000.0f;
    //float endpoint = 2500.0f;
	
	[terrain removeAllChildrenWithCleanup:YES];
	[terrain setData:terrainsData];
	[terrainsData release];
	[physics addTerrainLayer:terrain];
	
	[enemiesLayer removeAllChildrenWithCleanup:YES];
	[enemiesLayer setData:enemiesData];
	[enemiesData release];
	[physics addEnemyLayer:enemiesLayer];
	
	[[credits getCreditsMgr] removeAllChildrenWithCleanup:YES];
	[[credits getOxiesMgr] removeAllChildrenWithCleanup:YES];
	[credits setCreditsData:creditsData oxygens:oxygensData lives:livesData];
	[creditsData release]; [oxygensData release]; [livesData release];
	[physics setCreditsManager:[credits getCreditsMgr]];
	[physics setOxyManager:[credits getOxiesMgr]];
	
	[caveBack setPosition:ccp(endpoint, -50.0)];
	[blackness setPosition:ccp(endpoint+500.0f, -300.0)];	
	[caveFront setPosition:ccp(endpoint, -50.0)];	
	[physics setEndPoint:[NSNumber numberWithFloat:endpoint-200.0f]];
	
	[self schedule:@selector(step:) interval:1.0f/35.0f];
	[gaminglayer setTouchesEnabled:YES];
	level_finished = NO;
}

-(NSString*)getLevelName{
	return levelname;
}



-(void)setupEventObservers{
	// listen for when the jumpa character dies
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(characterDeath:)
												 name:@"jumpaCharacterDidDie" object:nil];
	
	// listen for game over
	// listen for when the jumpa character dies
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(gameIsOver:)
												 name:@"gameOver" object:nil];
	
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(deathFade:)
												 name:@"deathfade" object:nil];
	
	
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(stopLevel)
												 name:@"suffocate" object:nil];
	
}




-(void)startGame{
	RCMusicItem *titleMusic = [[RCMusicManager sharedMusicManager] getMusicItemWithName:@"title"];
	
	[titleMusic stop];
	
	[self setVisible:YES];
	
	[gaminglayer setPosition:ccp(0.0f, 0.0f)];
	//[self schedule:@selector(step:) interval:1.0f/35.0f];
	NSLog(@"startGame");

	
	sleep(1);

	[self startLevel];
	[fader_blackness runAction: initial_fade_in];

	[gaminglayer start];
	
	
	
	

//	id fadeout_map = [MusicFadeAction actionWithDuration:2.0f fadeTo:0.0f property:@"Volume" musicItem:[[RCMusicManager sharedMusicManager] getMusicItemWithName:@"map"]];
	//id fadein_level1 = [MusicFadeAction actionWithDuration:4.0f fadeTo:1.0f property:@"Volume" musicItem:[[RCMusicManager sharedMusicManager] getMusicItemWithName:@"level1"]];
	//[self runAction:fadein_level1];
//	id crossfade = [Spawn actions:fadeout_map, fadein_level1, nil];
//	[self runAction:crossfade];
	
	
	
		[level1Music play];
	
	//[level1 runAction:level1_seq];
	//[level1_start runAction:start_seq];

	
}

-(void)characterDeath:(NSNotification *)notification
{
	NSLog(@"DIE!");
	[fader_blackness runAction: death_fadeout_seq];
	[gaminglayer stopAllActions];
	[credits resetOxygens];

	
}

-(void)levelFinished{
	
	if(!level_finished){
		jumpaAppDelegate *appDelegate = (jumpaAppDelegate *)[UIApplication sharedApplication].delegate;
		[appDelegate commitScore];
		
		
		level_finished = YES;
		[gaminglayer setTouchesEnabled:NO];
		[gaminglayer forceLanding];
		[gaminglayer stopAllActions];
		[parralaxBackgrounds stopParallax];
		
		// need to keep selector going but stop death collisions
		//[self unschedule:@selector(step:)];
		
		float xmovement = gaminglayer.position.x +700.0f;
		
		float duration = 2.0f;
		
		
		id characterMovement = [[MoveTo actionWithDuration:duration position:ccp(xmovement,0.0f)] retain];
		
		
		[gaminglayer runAction:[Sequence actions:characterMovement, [CallFunc actionWithTarget:self selector:@selector(stopGame)], [CallFunc actionWithTarget:self selector:@selector(levelFinishedSequence)], nil]];
		
	}
}

-(void)stopGame{
	NSLog(@"stopgame!");
	[self unschedule:@selector(step:)];
}



-(void)hitCheckPoint:(NSNumber*)xpos{
	[checkpointLayer showCheckPoint];
	spawn_point = ccp([xpos floatValue],0.0f);
	
}

-(void)gameIsOver:(NSNotification *)notification
{
	jumpaAppDelegate *appDelegate = (jumpaAppDelegate *)[UIApplication sharedApplication].delegate;
	[appDelegate commitScore];
	//[appDelegate setGameScore:[NSNumber numberWithInt:[gaminglayer getCreditsCount]]];
	
	
	
	NSString *bestScore = [NSString stringWithFormat:@"HI %d", [[appDelegate getTopScore] intValue]];
	[jumpMeter setBestScoreLabel:bestScore];
	NSLog(@"game over!!!	");
	[credits resetCredits];
	[credits resetOxygens];
	
	[[creditMeterLayer sharedCreditMeter] setCreditsPercentage:[NSNumber numberWithFloat:0.0f]];
	//GameOverScene *gos = [GameOverScene node];
	//[[Director sharedDirector] replaceScene:gos];
	sleep(3);
	[self restartFromGameOver];
	[level1Music stop];
	[level1Music play];
	

	
}

-(void)stopMusic{
	[level1Music stop];
}

-(void)fadeOut{
	[fader_blackness runAction:fadeout];
}

-(void)deathFade:(NSNotification *)notification
{
	if([[[UIApplication sharedApplication] delegate] hasFastCPU]){
		[soundNode runAction:[Sequence actions:music_bendDown, music_bendUp,nil]];
	}
	
	[voidNode reorderChild:gaminglayer z:999];
	[fader_blackness setScale:10.0f];
	
	[fader_blackness setPosition:ccp(gaminglayer.position.x - 900,-500)];

	[fader_blackness runAction:fadeout];
	
	
	
	
}


-(void)levelFinishedSequence{
	id lvlFadeSeq = [Sequence actions:
					 [DelayTime actionWithDuration:2.4],
					 fadeout, 
					 [CallFunc actionWithTarget:self selector:@selector(startUnloadingScene)],
					 nil];
	[fader_blackness runAction:lvlFadeSeq];
	LevelFinishedOverlay *lvlfinishedOverlay = [[LevelFinishedOverlay alloc] init];
	lvlfinishedOverlay.transformAnchor = ccp(0,0);
	[self addChild:lvlfinishedOverlay z:900];
	[lvlfinishedOverlay startAnimation];
}

-(void)startUnloadingScene{
	//NSLog(@"start unloading the scene");
	LevelFinishedScene *lvlFin = [[LevelFinishedScene alloc] initWithCreditsScore:[gaminglayer getCreditsCount] livesScore:[gaminglayer getLivesCount] ];
	 [[Director sharedDirector] replaceScene:lvlFin];
}



-(void)addStarEmitter:(CGPoint)location{

	//fixme: dealloc this
	ParticleSystem *emitter = [particleStar node];
	[emitter setPosition:location];
	emitter.texture = [[TextureMgr sharedTextureMgr] addImage: @"superstars.png"];
	[voidNode addChild: emitter z:999];
	
}

- (void) setOpacity: (GLubyte)newOpacity
{
	//NSLog(@"setOpacity %d", newOpacity);
//	NSArray *children = [voidNode children];
//	for(int i=0;i<[children count];i++){
//		[[children objectAtIndex:i] setOpacity:newOpacity];
//	}
//	[parralaxBackgrounds setOpacity:newOpacity];

	
}







-(void)startLevel{
	//NSLog(@"gamescene: start level");
	// rate is 500 pixels every 3 seconds
	// => 166 frames a second
	//float xmovement = 5212.0f;
	
	float xmovement = level_width;
	float duration = (xmovement-spawn_point.x) / 300.0f;

	
	id characterMovement = [[MoveTo actionWithDuration:duration position:ccp(xmovement,0.0f)] retain];
	character_speed_action = [[Speed actionWithAction:characterMovement speed:1.2f] retain];
	
	id speedup = [MusicFadeAction actionWithDuration:180.0f fadeTo:2.3f property:@"CharacterSpeed" musicItem:self];
	
	
	[gaminglayer runAction:character_speed_action];
	[self runAction:speedup];

	
	
	[parralaxBackgrounds runParallax:[NSNumber numberWithFloat:20.0f]];

}


-(NSNumber*)getCharacterSpeed{
	return [NSNumber numberWithFloat:[character_speed_action speed]];
}

-(void)setCharacterSpeed:(NSNumber*)speed{
	//NSLog(@"set character speed : %f", [speed floatValue]);
	[character_speed_action setSpeed:[speed floatValue]];
}

-(void)restartFromGameOver{
	[gaminglayer stopAllActions];
	[credits resetOxygens];
	
	spawn_point = ccp(0.0f,0.0f);
	[fader_blackness runAction: initial_fade_in];

	[self restartLevel];
}

-(void)restartLevel{
	NSLog(@"gamescene: restartlevel");
	[voidNode reorderChild:gaminglayer z:5];
	[self stopAllActions];
	[physics resetCollisions];
	[gaminglayer setPosition:spawn_point];
	
	

	
	[fader_blackness setPosition:ccp(spawn_point.x - 300,-500)];
	[fader_blackness stopAllActions];
		[fader_blackness runAction:initial_fade_in];
//	[fader_blackness runAction:music_bendUp];
//	NSLog(@"bendup");
	
	[self startLevel];
	[gaminglayer respawn];
	

	[[oxyMeterLayer sharedOxyMeter] refresh];
}

-(void)stopLevel{
	[gaminglayer stopAllActions];
	[enemiesLayer stopAllActions];
	[terrain stopAllActions];
	[credits stopAllActions];
	[parralaxBackgrounds stopParallax];
	
	// SHAKE IT LIKE A POLAROID PICTURE
	id frame0_2= [MoveTo actionWithDuration:0.08 position:ccp(20,0)];
	id frame3_4= [MoveTo actionWithDuration:0.08 position:ccp(-8,0)];
	id frame5_6= [MoveTo actionWithDuration:0.08 position:ccp(5,0)];
	id frame7_8= [MoveTo actionWithDuration:0.08 position:ccp(0,0)];
	id seq = [Sequence actions: frame0_2, frame3_4, frame5_6, frame7_8,nil];
	[voidNode runAction:seq];
	
}

-(void) draw{
	
	CGRect charbounds = gaminglayer.charbounds;
	


	
	
	
	if(!level_finished){
		
		float chary = 689;
		
		if(charbounds.origin.y <= 689){
			chary = charbounds.origin.y;
		}
		
		if(chary < 0){
			chary = 0;
		}
		
		// MAX Y = 689
		[voidNode.camera setEyeX:gaminglayer.position.x +170 eyeY:295 eyeZ:600+(chary)];
		[voidNode.camera setCenterX:gaminglayer.position.x +170 centerY:295+(chary/3) centerZ:0];
		
		[parralaxBackgrounds.sceneryNode.camera setEyeX:180 eyeY:227+(chary/8)  eyeZ:510 + (chary/6)];
		[parralaxBackgrounds.sceneryNode.camera setCenterX:180 centerY:227+(chary/8)  centerZ:500];
		
		[parralaxBackgrounds.backgroundNode.camera setEyeX:0 eyeY:250+(chary/20) eyeZ:400];
		[parralaxBackgrounds.backgroundNode.camera setCenterX:0 centerY:250+(chary/20)  centerZ:0];
		
		[parralaxBackgrounds.cloudsNode.camera setEyeX:180 eyeY:250+(chary/10)  eyeZ:700];
		[parralaxBackgrounds.cloudsNode.camera setCenterX:180 centerY:250+(chary/10)  centerZ:0];
		
		
		
	}else{
		//[voidNode.camera setEyeX:gaminglayer.position.x +350 + (gaminglayer.position.x/10)  eyeY:255 eyeZ:700+(charbounds.origin.y/4)];
		//[voidNode.camera setCenterX:gaminglayer.position.x + 170 +(gaminglayer.position.x/10) centerY:255+(charbounds.origin.y/4) centerZ:0];
	}
	
	
	
	//[[[PASoundMgr sharedSoundManager] listener] setPosition:ccp(gaminglayer.position.x, 900)];
	//[[[PASoundMgr sharedSoundManager] listener] setPosition:ccp(9000.0f, 900.0f)];
	
	

	
	
#ifdef DEBUG_MODE
	[self drawWireFrames];
#endif
	
		
}

-(void)drawWireFrames{
	
	// draws the bounding boxes for enemies and terrain
	glColor4f(1.0f, 1.0f, 1.0f, 1.0f);
	NSArray *enemy_children = [enemiesLayer children];
	
	//enemies contains a bounds object
	
	for(int i=0; i<[enemy_children count];i++){
		 boundedSprite *current = [enemy_children objectAtIndex:i];
		CGRect coords = current.charbounds;
		//CGPoint abspos = [current absolutePosition];

		
		// make a bounding box around the character
		// left 
		drawLine(ccp(coords.origin.x, coords.origin.y), ccp(coords.origin.x, coords.origin.y + coords.size.height));
		// right
		drawLine(ccp(coords.origin.x + coords.size.width, coords.origin.y), ccp(coords.origin.x + coords.size.width, coords.origin.y + coords.size.height));
		//top
		drawLine(ccp(coords.origin.x, coords.origin.y + coords.size.height), ccp(coords.origin.x + coords.size.width, coords.origin.y + coords.size.height));
		//bottom
		drawLine(ccp(coords.origin.x, coords.origin.y), ccp(coords.origin.x + coords.size.width, coords.origin.y));
		
	}

	NSArray *terrain_children = [terrain children];
	
	//terrain contains a bounds object
	for(int i=0; i<[terrain_children count];i++){
		boundedSprite *current = [terrain_children objectAtIndex:i];
		CGRect coords = current.charbounds;
		CGPoint abspos = [current absolutePosition];
		
		coords.origin.x = abspos.x; //+coords.origin.x;
		coords.origin.y = abspos.y; //+ coords.origin.y;
		
		// make a bounding box around the character
		// left 
		drawLine(ccp(coords.origin.x, coords.origin.y), ccp(coords.origin.x, coords.origin.y + coords.size.height));
		// right
		drawLine(ccp(coords.origin.x + coords.size.width, coords.origin.y), ccp(coords.origin.x + coords.size.width, coords.origin.y + coords.size.height));
		//top
		drawLine(ccp(coords.origin.x, coords.origin.y + coords.size.height), ccp(coords.origin.x + coords.size.width, coords.origin.y + coords.size.height));
		//bottom
		drawLine(ccp(coords.origin.x, coords.origin.y), ccp(coords.origin.x + coords.size.width, coords.origin.y));
		
	}
	
	CGRect coords = gaminglayer.absoluteBounds;
	// make a bounding box around the character
	// left 
	drawLine(ccp(coords.origin.x, coords.origin.y), ccp(coords.origin.x, coords.origin.y + coords.size.height));
	// right
	drawLine(ccp(coords.origin.x + coords.size.width, coords.origin.y), ccp(coords.origin.x + coords.size.width, coords.origin.y + coords.size.height));
	//top
	drawLine(ccp(coords.origin.x, coords.origin.y + coords.size.height), ccp(coords.origin.x + coords.size.width, coords.origin.y + coords.size.height));
	//bottom
	drawLine(ccp(coords.origin.x, coords.origin.y), ccp(coords.origin.x + coords.size.width, coords.origin.y));
	

	
}


-(void) step: (ccTime) dt
{
	ticks++;	
	
	// argument: allow death?
	[physics update:ticks];
	
	
	
	
}


-(BOOL)togglePause{
	if(paused){
		[[[RCMusicManager sharedMusicManager] getMusicItemWithName:@"level1"] resume];
		[gaminglayer setTouchesEnabled:YES];
		[[Director sharedDirector] resume];
	}else{
		[[Director sharedDirector] pause];
		[[SFXManager sharedSoundManager] stopLoops];
		[gaminglayer setTouchesEnabled:NO];
		[[[RCMusicManager sharedMusicManager] getMusicItemWithName:@"level1"] pause];
	}
	paused = !paused;
	return paused;
}

@end

@implementation GameLayer
@synthesize charbounds;
@synthesize abspos;
@synthesize absoluteBounds;

- (id) init {
    self = [super init];
    if (self != nil) {
		jumpaCharacter = [[JumpaCharacterLayer node] retain];
		
		[self addChild:jumpaCharacter z:1];
		
		jumpaAppDelegate *appDelegate = (jumpaAppDelegate *)[UIApplication sharedApplication].delegate;
		collisionphysics *physics = [appDelegate jumpaCollisionPhysics];
		[physics setCharacterSprite:jumpaCharacter];
		


    }
    return self;
}

-(void)start{
	NSLog(@"gamelayer : start");
	[jumpaCharacter spawn];

}

-(void)draw{
	charbounds = [jumpaCharacter charbounds];
	CGRect absboonds = [jumpaCharacter absoluteBounds];
	abspos = ccp(absboonds.origin.x, absboonds.origin.y);
	
}

-(void)setHud:(jumpMeterLayer*)theHud{
	[jumpaCharacter setHud:theHud];

}

-(void)initSfx
{
	[jumpaCharacter initSfx];
}

-(void)setSfxManager:(SFXManager*)theManager{
	[jumpaCharacter setSfx:theManager];
}

-(void)respawn
{
	[jumpaCharacter spawn];
}

-(void)setTouchesEnabled:(BOOL)enabled{
	[jumpaCharacter setIsTouchEnabled:enabled];
}

-(void)forceLanding{
	
	if(jumpaCharacter.current_state != STATE_RUNNNING){
		[jumpaCharacter doFallFromPoint:jumpaCharacter.abspos];
	}
}

- (void) setOpacity: (GLubyte)newOpacity
{

	NSArray *children = [self children];
	for(int i=0;i<[children count];i++){
		[[children objectAtIndex:i] setOpacity:newOpacity];
	}
	
}

-(int)getLivesCount{
	return [jumpaCharacter getLivesCounter];
}

-(int)getCreditsCount{
	return [jumpaCharacter getCreditsCounter];
}

-(void)resetCredits{
	NSLog(@"gamelayer: resetcredits");
	[jumpaCharacter resetCreditsCounter];
}







@end



	



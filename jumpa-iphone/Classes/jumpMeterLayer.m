//
//  jumpMeterLayer.m
//  Untitled
//
//  Created by harry on 22/09/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "jumpMeterLayer.h"
#import "MaskTo.h"
#import "GameScene.h"

#import "animatedBoundedSprite.h"

@implementation jumpMeterLayer

-(id)init{
	if( ![super init] )
		return nil;
	
	if(![[[UIApplication sharedApplication] delegate] isIpad]){
		JUMPMETER_UIBACKGROUND_X = JUMPMETER_UIBACKGROUND_IPHONE_X;
		JUMPMETER_UIBACKGROUND_Y = JUMPMETER_UIBACKGROUND_IPHONE_Y;
		JUMPMETER_HANGMETER_X = JUMPMETER_HANGMETER_IPHONE_X ;
		JUMPMETER_HANGMETER_Y = JUMPMETER_HANGMETER_IPHONE_Y;
		JUMPMETER_CREDITSCOUNTERLABEL_X = JUMPMETER_CREDITSCOUNTERLABEL_IPHONE_X;
		JUMPMETER_CREDITSCOUNTERLABEL_Y = JUMPMETER_CREDITSCOUNTERLABEL_IPHONE_Y;
		JUMPMETER_LIVESCOUNTERLABEL_X = JUMPMETER_LIVESCOUNTERLABEL_IPHONE_X;
		JUMPMETER_LIVESCOUNTERLABEL_Y = JUMPMETER_LIVESCOUNTERLABEL_IPHONE_Y;
		JUMPMETER_CREDITSIMG_X = JUMPMETER_CREDITSIMG_IPHONE_X;
		JUMPMETER_CREDITSIMG_Y = JUMPMETER_CREDITSIMG_IPHONE_Y;
		JUMPMETER_LIVESIMG_X = JUMPMETER_LIVESIMG_IPHONE_X;
		JUMPMETER_LIVESIMG_Y = JUMPMETER_LIVESIMG_IPHONE_Y;
		JUMPMETER_OXYMETER_X = JUMPMETER_OXYMETER_IPHONE_X;
		JUMPMETER_OXYMETER_Y = JUMPMETER_OXYMETER_IPHONE_Y;
		JUMPMETER_BESTSCORE_X = JUMPMETER_BESTSCORE_IPHONE_X;
		JUMPMETER_BESTSCORE_Y = JUMPMETER_BESTSCORE_IPHONE_Y;
	}else{
		JUMPMETER_UIBACKGROUND_X = JUMPMETER_UIBACKGROUND_IPAD_X;
		JUMPMETER_UIBACKGROUND_Y = JUMPMETER_UIBACKGROUND_IPAD_Y;
		JUMPMETER_HANGMETER_X = JUMPMETER_HANGMETER_IPAD_X ;
		JUMPMETER_HANGMETER_Y = JUMPMETER_HANGMETER_IPAD_Y;
		JUMPMETER_CREDITSCOUNTERLABEL_X = JUMPMETER_CREDITSCOUNTERLABEL_IPAD_X;
		JUMPMETER_CREDITSCOUNTERLABEL_Y = JUMPMETER_CREDITSCOUNTERLABEL_IPAD_Y;
		JUMPMETER_LIVESCOUNTERLABEL_X = JUMPMETER_LIVESCOUNTERLABEL_IPAD_X;
		JUMPMETER_LIVESCOUNTERLABEL_Y = JUMPMETER_LIVESCOUNTERLABEL_IPAD_Y;
		JUMPMETER_CREDITSIMG_X = JUMPMETER_CREDITSIMG_IPAD_X;
		JUMPMETER_CREDITSIMG_Y = JUMPMETER_CREDITSIMG_IPAD_Y;
		JUMPMETER_LIVESIMG_X = JUMPMETER_LIVESIMG_IPAD_X;
		JUMPMETER_LIVESIMG_Y = JUMPMETER_LIVESIMG_IPAD_Y;
		JUMPMETER_OXYMETER_X = JUMPMETER_OXYMETER_IPAD_X;
		JUMPMETER_OXYMETER_Y = JUMPMETER_OXYMETER_IPAD_Y;
		JUMPMETER_BESTSCORE_X = JUMPMETER_BESTSCORE_IPAD_X;
		JUMPMETER_BESTSCORE_Y = JUMPMETER_BESTSCORE_IPAD_Y;
	}
	
	current_state = STATE_JUMP1;
	
	if(![[[UIApplication sharedApplication] delegate] isIpad]){
		//Sprite *UIbackground = [Sprite spriteWithFile:@"UIbackground.png"];
		//UIbackground.transformAnchor = ccp(0,0);
		//UIbackground.position = ccp(JUMPMETER_UIBACKGROUND_X,JUMPMETER_UIBACKGROUND_Y);
		//[self addChild:UIbackground];
		//[UIbackground retain];
	}
	
	if([[[UIApplication sharedApplication] delegate] isIpad]){
		Sprite *spotlight = [Sprite spriteWithPVRTCFile:@"spotlight_hd.pvr" bpp:4 hasAlpha:YES width:1024];
		spotlight.transformAnchor = ccp(0,0);
		//spotlight.scaleX=2.13f;
		//spotlight.scaleY=2.4f;
		spotlight.position = ccp(-544,0);
		[self addChild:spotlight];
	}
	
	



	[self addChild:[creditMeterLayer sharedCreditMeter]];
// credits meter ws here
	
	MenuItemImage *item1 = [MenuItemImage itemFromNormalImage:@"PauseButton.png" selectedImage:@"PauseButton.png" target:self selector:@selector(togglePause:)];
	Menu *menu = [Menu menuWithItems:item1, nil];
	menu.position = CGPointZero;
	item1.position = ccp(28,300);
	[item1 setScale:0.7];
	
	[self addChild:menu];
	
	
	
	[self addChild:[oxyMeterLayer sharedOxyMeter]];
	[oxyMeterLayer sharedOxyMeter].position = ccp (JUMPMETER_OXYMETER_X, JUMPMETER_OXYMETER_Y);
	
	
	// ///
	
	creditsCounterLabel = [LabelAtlas labelAtlasWithString:@"0" charMapFile:@"tuffy_small.png" itemWidth:12 itemHeight:16 startCharMap:' '];
	
	[self addChild:creditsCounterLabel];
	[creditsCounterLabel retain];
	
	creditsCounterLabel.position = ccp(JUMPMETER_CREDITSCOUNTERLABEL_X,JUMPMETER_CREDITSCOUNTERLABEL_Y);
	[creditsCounterLabel setScale:1.0f];
	
	NSString *bestScore = [NSString stringWithFormat:@"HI NA"];
	
	bestScoreLabel =[LabelAtlas labelAtlasWithString:bestScore charMapFile:@"tuffy_small.png" itemWidth:12 itemHeight:16 startCharMap:' '];
	[self addChild:bestScoreLabel];
	[bestScoreLabel retain];
	
	bestScoreLabel.position = ccp(JUMPMETER_BESTSCORE_X,JUMPMETER_BESTSCORE_Y);
	[bestScoreLabel setScale:1.0f];


	livesCounterLabel = [LabelAtlas labelAtlasWithString:@"5" charMapFile:@"tuffy_bold_italic-charmap.png" itemWidth:48 itemHeight:64 startCharMap:' '];
	
	//[self addChild:livesCounterLabel];
	[livesCounterLabel retain];
	
	livesCounterLabel.position = ccp(JUMPMETER_LIVESCOUNTERLABEL_X,JUMPMETER_LIVESCOUNTERLABEL_Y);
	[livesCounterLabel setScale:0.7f];
	
	//Sprite *creditsImg = [[Sprite spriteWithFile:@"HudCredits.png"] retain];
	//Sprite *livesImg = [[Sprite spriteWithFile:@"HudLifea.png"] retain];
	
	//creditsImg.transformAnchor = ccp(0,0);
	//creditsImg.position = ccp(JUMPMETER_CREDITSIMG_X, JUMPMETER_CREDITSIMG_Y);
	//[creditsImg setScale:0.5f];
	
	//livesImg.transformAnchor = ccp(0,0);
	//livesImg.position = ccp(JUMPMETER_LIVESIMG_X, JUMPMETER_LIVESIMG_Y);
	
	//[self addChild:creditsImg];
	//[self addChild:livesImg];
	
		
	
	// add the pause layer
	
	
	pauseLayer = [[Layer node] retain];
	
	Sprite *pauseOverlay = [Sprite spriteWithFile:@"BlackRibbon.png"];
	pauseOverlay.transformAnchor = ccp(0,0);
	pauseOverlay.position = ccp(0,0);
	[pauseOverlay setOpacity:128];
	[pauseLayer addChild:pauseOverlay];
	
	[MenuItemFont setFontSize:20];
	[MenuItemFont setFontName:@"Helvetica"];
	MenuItem *start = [MenuItemImage itemFromNormalImage:@"PauseButtonUp.png" 
										   selectedImage:@"PauseButtonUp.png"
										   target:self
										   selector:@selector(resumeGame:)];
	
	
	MenuItem *help =  [MenuItemImage itemFromNormalImage:@"MenuButtonUp.png" 
										   selectedImage:@"MenuButtonUp.png"
												  target:self
												selector:@selector(exitToMenu:)];
	
	Menu *pauseMenu = [Menu menuWithItems:help,start, nil];
	[pauseMenu alignItemsHorizontally];
	[pauseLayer addChild:pauseMenu];
	
	
	


	
	
	return self;
	
}

-(void)refreshOxy{
	//NSLog(@"jumpmeterlayer: refreshOxy");
	[[oxyMeterLayer sharedOxyMeter] refresh];
}


-(void)setBestScoreLabel:(NSString*)string{
	[bestScoreLabel setString:string];
}

-(void)setCreditsLabel:(NSString*)string
{
	////NSLog(@"setting credits label to %@", string);
	[creditsCounterLabel setString:string];
}

-(void)setLivesLabel:(NSString*)string
{
	////NSLog(@"setting lives label to %@", string);
	[livesCounterLabel setString:string];
}


-(void)togglePause: (id)sender {
	
	BOOL paused = [[GameScene sharedGameScene] togglePause];
	
	
	//TODO: resume loops if walking
	if(paused)
		[self addChild:pauseLayer];
		
	else {
		[self removeChild:pauseLayer cleanup:NO];
	}

}

-(void)resumeGame:(id)sender{
	[self togglePause:nil];
}

-(void)exitToMenu:(id)sender{
	[[[UIApplication sharedApplication] delegate] runMenuScene];
	[[GameScene sharedGameScene] stopMusic]; 
	[[SFXManager sharedSoundManager] stopLoops];
	[self removeChild:pauseLayer cleanup:NO];
	[[Director sharedDirector] resume];
}

-(void)setState:(NSNumber*)state{

	[hangMgr_jump1 setVisible:NO];
	[hangMgr_jump2 setVisible:NO];
	[hangMgr_jump3 setVisible:NO];
	[hangMgr_none setVisible:NO];
	
	int thestate = [state intValue];
	
	current_state = thestate;

	id jumpOut;
	id mask;
	id shiz;
	
	// move all jump meters back to their original positions
	jumpOut = [MoveBy actionWithDuration:0.0 position:ccp(0,0)];
	mask = [MaskTo actionWithDuration:0.0 rect:CGRectMake(0, 0, 128, 32)];
	shiz = [Spawn actions:jumpOut, mask, nil];
	
	[hangMeter_jump1 runAction:shiz];
	[hangMeter_jump2 runAction:shiz];
	[hangMeter_jump3 runAction:shiz];
	[hangMeter_none runAction:shiz];
	
	
	
	
	switch (thestate) {
		case STATE_JUMP1:
			[hangMgr_jump1 setVisible:YES];
			[hangMgr_jump2 setVisible:YES];
			break;
		case STATE_JUMP2:
			[hangMgr_jump2 setVisible:YES];
			[hangMgr_jump3 setVisible:YES];
			break;
		case STATE_JUMP3:
			[hangMgr_jump3 setVisible:YES];
			[hangMgr_none setVisible:YES];
			break;
		default:
			break;
	}
}


@end

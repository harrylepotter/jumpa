//
//  LevelSelectScene.m
//  jumpa
//
//  Created by harry on 3/01/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LevelSelectScene.h"
#import "LevelSelectLayer.h"

@implementation LevelSelectScene

static LevelSelectScene *sharedLevelSelectScene = nil;

+ (LevelSelectScene *)sharedLevelSelectScene {
	@synchronized(self)	{
		if (!sharedLevelSelectScene){
			sharedLevelSelectScene = [[LevelSelectScene alloc] init];            
        }
		return sharedLevelSelectScene;
	}
	// to avoid compiler warning
	return nil;
}


-(id)init{
	NSLog(@"levelselectScene: init");
	self = [super init];
	
	
	
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

	
	Sprite *overlay = [Sprite spriteWithFile:@"levelselect_overlay.png"];
	overlay.transformAnchor = ccp(0,0);
	overlay.position = ccp(0,0);
	[self addChild:overlay];
	
	
	[self setLevelSelection];
	
	return self;
}

-(void)setLevelSelection{
	jumpaAppDelegate *appDelegate = (jumpaAppDelegate *)[UIApplication sharedApplication].delegate;
	NSMutableDictionary *states = [appDelegate getUnlockables];
	
	
	if(levelSelectLayer != nil){
		[self removeChild:levelSelectLayer cleanup:YES];
		[levelSelectLayer release];
		levelSelectLayer = nil;
	}
	
	levelSelectLayer = [[LevelSelectLayer alloc] initWithStates:states];
	[self add:levelSelectLayer];
	
}

-(void)scrollingStarsReset1{
	stars_scrolling.position = ccp(-544,0);
}

-(void)scrollingStarsReset2{
	stars_scrolling2.position = ccp(480,0);
}

@end

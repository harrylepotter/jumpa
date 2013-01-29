//
//  MenuScene.m
//  Untitled
//
//  Created by Harry Potter on 2/07/09.
//  Copyright Synthesia 2009. All rights reserved.
//


#import "MenuScene.h"
#import "LevelSelectScene.h"
//#import "GameScene.h"


@implementation MenuScene
- (id) init {
	
	self = [super init];
	
	if (self != nil) {
		ml = [[MenuLayer node] retain];
        [self addChild:ml z:1];
    }
	
    return self;
}

-(void)displayMenuScene{
	[ml displayMenuScene];
}

@end

@implementation MenuLayer
- (id) init {
    self = [super init];
	
    if (self != nil) {
		
		if(![[[UIApplication sharedApplication] delegate] isIpad]){
			splash = [MenuItemImage itemFromNormalImage:@"splash1.png" selectedImage:@"splash2.png" target:self selector:@selector(startGame:)];
			splash.position = CGPointZero;
		}else{
			splash = [MenuItemImage itemFromNormalImage:@"hd_splash1.png" selectedImage:@"hd_splash2.png" target:self selector:@selector(startGame:)];
			splash.position = ccp(-544,0);
		}
		
		menu = [Menu menuWithItems:splash, nil];
		menu.position = CGPointZero;
		splash.transformAnchor = CGPointZero;
		
		

		
        [self addChild:menu];
				
		fadeout_action = [[FadeOut actionWithDuration:1.0f] retain];
		fadeout_finished = [[CallFunc actionWithTarget:self selector:@selector(switchToGameScene:)] retain];
		seq = [[Sequence actions:
				fadeout_action,
				fadeout_finished,
				nil] retain];	
		
		fadein_action = [[FadeIn actionWithDuration:1.0f] retain];
		[menu setOpacity:0.0f];
		
    }
	
	 gs = [[[UIApplication sharedApplication] delegate] getSharedGameScene];
	
	RCMusicItem *level1Music = [[RCMusicManager sharedMusicManager] addMusicItemWithName:@"title"];
	
    return self;


}

-(void)displayMenuScene{
	//NSLog(@"menuscene: displaymenuscene");
	[menu runAction:fadein_action];
	RCMusicItem *level1Music = [[RCMusicManager sharedMusicManager] getMusicItemWithName:@"title"];
	[level1Music setVolume:[NSNumber numberWithFloat:1.0f]];
	[level1Music play];
	
}


-(void)startGame: (id)sender {
	//NSLog(@"menuscene: startgame");
	[splash stopAllActions];
	[splash runAction:seq];
	[[SFXManager sharedSoundManager] playSound:@"menutouch" atPosition:CGPointZero];
	

}

-(void)switchToGameScene: (id)sender {

	//[[Director sharedDirector] replaceScene:gs];
	//[gs startGame];

	[[Director sharedDirector] replaceScene:[LevelSelectScene sharedLevelSelectScene]];
}


-(void)help: (id)sender {
    //NSLog(@"help");
}
@end

//
//  MenuScene.m
//  Untitled
//
//  Created by Harry Potter on 2/07/09.
//  Copyright Synthesia 2009. All rights reserved.
//


#import "GameOverScene.h"



@implementation GameOverScene
- (id) init {
	
	self = [super init];
	
	if (self != nil) {
		GameOverLayer *gol = [GameOverLayer node];
		[self addChild:gol];
    }
	
    return self;
}


@end

@implementation GameOverLayer
- (id) init {
	NSLog(@"gameoverlayer : init");
    self = [super init];
	
    if (self != nil) {

		if(![[[UIApplication sharedApplication] delegate] isIpad]){
			gameOverImage = [MenuItemImage itemFromNormalImage:@"gameover1.png" selectedImage:@"gameover2.png" target:self selector:@selector(restartGame:)];
			gameOverImage.position = CGPointZero;
		}else{
			gameOverImage = [MenuItemImage itemFromNormalImage:@"gameover1_hd.png" selectedImage:@"gameover2_hd.png" target:self selector:@selector(restartGame:)];
			gameOverImage.position = ccp(-544,0);
		}
		
		menu = [Menu menuWithItems:gameOverImage, nil];
		menu.position = CGPointZero;
		gameOverImage.transformAnchor = CGPointZero;
		
        [self addChild:menu];
		return self;
	
	}
}

-(void)restartGame: (id)sender {
	NSLog(@"gameoverscene: restartgame");
	[[SFXManager sharedSoundManager] playSound:@"menutouch" atPosition:CGPointZero];
	id gameScene = [[[UIApplication sharedApplication] delegate] getSharedGameScene];
	[[Director sharedDirector] replaceScene:gameScene];
	[gameScene restartFromGameOver];
}

@end

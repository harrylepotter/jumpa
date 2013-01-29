//
//  LevelSelectLayer.h
//  menu
//
//  Created by harry on 30/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "difficultymenuitem.h"
#import "easymenuitem.h"
#import "mediummenuitem.h"
#import "extememenuitem.h"
#import "hardmenuitem.h"
#import "GameScene.h"

@interface LevelSelectLayer : Layer {

	easymenuitem *easy;
	mediummenuitem *medium;
	hardmenuitem *hard;
	extememenuitem *extreme;
	
	NSArray *items;
	
	
	NSMutableDictionary *unlockStates;
	
	NSMutableData *responseData;

}

- (BOOL)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;
- (BOOL)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
-(NSMutableDictionary*)unlockStates;
-(void)setUnlockStates:(NSMutableDictionary*)unlockStates;
-(void)loadLevel:(int)level;

@end

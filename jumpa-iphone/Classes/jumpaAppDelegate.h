//
//  UntitledAppDelegate.h.h
//  Untitled
//
//  Created by Harry Potter on 2/07/09.
//  Copyright Synthesia 2009. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "cocos2d.h"
#import "MenuScene.h"
#import "GameScene.h"
#import "chipmunk.h"
#import "collisionphysics.h"
#import "LoadingScene.h"
#import "creditMeterLayer.h"

@interface jumpaAppDelegate : NSObject <UIApplicationDelegate> {
	collisionphysics *jumpaCollisionPhysics;
	LoadingScene *loadingscene;
	MenuScene *ms;
	
	NSLock *loadingthreadLock;
	BOOL is_ipad;
	BOOL loadInternetLevels;
	
	int current_score;
	int maximum_score;
	float score_percent;
	
	NSMutableDictionary *unlockables;
}

@property (nonatomic, retain) collisionphysics *jumpaCollisionPhysics;
@property BOOL loadInternetLevels;
-(BOOL)hasFastCPU;
-(int)getMaximumPossibleScore;
-(float)getScorePercent;
-(NSMutableDictionary*)getUnlockables;
-(void)writeUnlockables;

@end

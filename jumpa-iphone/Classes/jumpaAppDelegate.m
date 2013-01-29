//
//  UntitledAppDelegate.m
//  Untitled
//
//  Created by Harry Potter on 2/07/09.
//  Copyright Synthesia 2009. All rights reserved.
//

#import "jumpaAppDelegate.h"
#import "jumpaMoviePlayer.h"


@interface jumpaAppDelegate(Private)
-(void) setupGameState;
@end

@implementation jumpaAppDelegate
@synthesize jumpaCollisionPhysics;
@synthesize loadInternetLevels;


- (void)applicationDidFinishLaunching:(UIApplication *)application {
	current_score = 0;
	maximum_score = 0;
	loadingthreadLock = [[NSLock alloc] init];
	
	
	self.jumpaCollisionPhysics = [[collisionphysics alloc] init];
	[[UIApplication sharedApplication] setStatusBarHidden:YES];
	
    UIWindow *window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	
	//UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"Load internet defs?" message:@"load internet level definitions?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil] autorelease];
    // optional - add more buttons:
    //[alert addButtonWithTitle:@"Yes"];
    //[alert show];
	
	self.loadInternetLevels = NO;
	
    [window setUserInteractionEnabled:YES];
    [window setMultipleTouchEnabled:NO];
	
	[[Director sharedDirector] setLandscape: YES];
	
    [[Director sharedDirector] attachInWindow:window];

    [window makeKeyAndVisible];
	
	
	
	UIDevice *device = [UIDevice currentDevice];
	NSString *systemName = [device systemName];
	NSString *type = [[UIDevice currentDevice] localizedModel];
	NSLog(@"type = %@", type);
	if([type isEqualToString:@"iPad"]){
		NSLog(@"IS IPAD MANG");
		is_ipad = YES;
	}else{
		is_ipad = NO;
	}
	
//	if( [[UIScreen mainScreen] bounds].size.width > 320.0f){
//		is_ipad = YES;
//	}
	
	unlockables = [[NSUserDefaults standardUserDefaults] dictionaryForKey:@"unlockables"];
	if(unlockables == nil){
		unlockables = [[[NSMutableDictionary alloc] initWithCapacity:4] retain];
		[unlockables setObject:[NSNumber numberWithInt:STATE_UNLOCKED] forKey:@"easy"];
		[unlockables setObject:[NSNumber numberWithInt:STATE_LOCKED] forKey:@"medium"];
		[unlockables setObject:[NSNumber numberWithInt:STATE_LOCKED] forKey:@"hard"];
		[unlockables setObject:[NSNumber numberWithInt:STATE_LOCKED] forKey:@"extreme"];
		[[NSUserDefaults standardUserDefaults] setObject:unlockables forKey:@"unlockables"];
	}
	
	
	
	
	loadingscene = [[LoadingScene node] retain];
	
	[self setupGameState];
	[self getTopScore];
	
	[self doLoadingScene];
	
}

-(void)runMenuScene{
	[ms displayMenuScene];
	[[Director sharedDirector] replaceScene:ms];
	//[loadingscene release];
}

-(id)getSharedGameScene{
	return [GameScene sharedGameScene];
}


-(void)doLoadingScene{
	
	NSThread *loadingThread = [[NSThread alloc] initWithTarget:self selector:@selector(doLoadingSceneThread) object:nil];
	[loadingThread start];
	
	[[Director sharedDirector] runWithScene:loadingscene];
	[loadingscene start];

}

-(void)doLoadingSceneThread{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	
	EAGLContext *k_context = [[[EAGLContext alloc]
							   initWithAPI:kEAGLRenderingAPIOpenGLES1
							   sharegroup:[[[[Director sharedDirector] openGLView] context] sharegroup]] autorelease];
	
	[EAGLContext setCurrentContext:k_context];
	//[self doPreloadLevel];
	
	ms = [[MenuScene node] retain];
	
	//NSLog(@"menu scene loaded");
	[loadingscene loadingDidFinish];	

	[pool release];
	
}


-(void) setupGameState {
}


-(NSNumber*)getTopScore{
	
	NSString *topScoreKey = [NSString stringWithFormat:@"topscore_%@",  [[GameScene sharedGameScene] getLevelName]];
	int topscore = [[NSUserDefaults standardUserDefaults] integerForKey:topScoreKey];
	return [NSNumber numberWithInt:topscore];

}



-(void)setMaximumPossibleScore:(NSNumber*)score{
	NSLog(@"set maximum possible score : %d", [score intValue]);
	maximum_score = [score intValue];
}

-(int)getMaximumPossibleScore{
	return maximum_score;
}


-(void)setGameScore:(NSNumber*)score{
	
	current_score = [score intValue];
	score_percent = (((float)(current_score))/((float)(maximum_score)*0.6));
	NSNumber *percent_num = [NSNumber numberWithFloat:score_percent];
	[[creditMeterLayer sharedCreditMeter] setCreditsPercentage:percent_num];

}

-(float)getScorePercent{
	return score_percent;
}


-(void)commitScore{
	NSLog(@"commitScore : committing score to IO");
	int currentTopScore = [[self getTopScore] intValue];
	if(current_score > currentTopScore){
		NSString *topScoreKey = [NSString stringWithFormat:@"topscore_%@",  [[GameScene sharedGameScene] getLevelName]];
		[[NSUserDefaults standardUserDefaults] setInteger:current_score forKey:topScoreKey];
	}
	
	
}


//-(void)clearTopScore{
//	NSLog(@"clearing top score");
//	[[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"topscore"];
//}

-(BOOL)isIpad{
	//return is_ipad;
	return FALSE;
}

-(BOOL)hasFastCPU{
	return is_ipad;
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        NSLog(@"loading definitions from internet");
		self.loadInternetLevels = YES;
    }else{
		self.loadInternetLevels = NO;
	}
	[self doLoadingScene];
}

-(void)applicationWillTerminate:(UIApplication *)application
{
    [application setIdleTimerDisabled:NO];
	[self commitScore];
	
}


-(NSMutableDictionary*)getUnlockables{
	return unlockables;
}

-(void)writeUnlockables{
	NSLog(@"WRITING UNLOCKABLES %@", unlockables);
	[[NSUserDefaults standardUserDefaults] setObject:unlockables forKey:@"unlockables"];
}


@end
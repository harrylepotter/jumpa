//
//  LoadingScene.m
//  jumpa
//
//  Created by harry on 5/10/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "LoadingScene.h"
#import "jumpaAppDelegate.h"

@implementation LoadingScene

-(id) init
{
	if( ![super init] )
		return nil;
	isLoaded = NO;
	
	loadingscreen = [LoadingLayer node];
	[self addChild:loadingscreen];
	return self;
}

-(void)loadingDidFinish{
	//NSLog(@"loading did finish");
	isLoaded = YES;
}
-(void)finishedLoading{
	//NSLog(@"finished loading");
	[loadingscreen finishedLoading];
}

-(void)start{
	[loadingscreen start];
}


-(void)draw{
	////NSLog(@"draw");
	if(isLoaded){
		[self finishedLoading];
		isLoaded = NO;
	}
	
	
}

@end


@implementation LoadingLayer

-(id) init
{
	//NSLog(@"loadinglayer: init");
	if( ![super init] )
		return nil;
	voidNode = [[Sprite node] retain];
	[self addChild:voidNode];
	
	loadingScreen = [[Sprite spriteWithFile:@"loading.png"] retain];
	loadingScreen.rotation = 270.0f;
	

	
	runmgr = [[AtlasSpriteManager spriteManagerWithFile:@"run.png" capacity:50] retain];
	run = [[AtlasSprite spriteWithRect:CGRectMake(0, 0, 64, 74) spriteManager: runmgr] retain];
	[runmgr addChild:run];
	AtlasAnimation *runanim = [[AtlasAnimation animationWithName:@"run" delay:0.06f] retain];
	
	for(int i=0;i<10;i++) {
		int x= i % 5;
		int y= i / 5;
		[runanim addFrameWithRect: CGRectMake(x*64, y*74, 64, 74) ];
		
	}
	
	run.transformAnchor = ccp(0,0);
	
	if([[[UIApplication sharedApplication] delegate] isIpad]){
		NSLog(@"IS AN IPAD");
		loadingScreen.scale = 1.25f;
		run.scale = 1.25f;
		loadingScreen.position = ccp(320,160);
		run.position = ccp(270, 120);
	}else{
		NSLog(@"IS NOT AN IPAD");
		loadingScreen.position = ccp(240,160);
		run.position = ccp(190, 130);
	}
	
	
	[voidNode addChild:loadingScreen];
	[voidNode addChild:runmgr z:10 tag:1];


	

	[run setOpacity:0.0f];
	run_action = [[Animate actionWithAnimation: runanim] retain];
	run_loop_action = [[RepeatForever actionWithAction:run_action] retain];
	fadein = [[FadeIn actionWithDuration:5.0f] retain];
	finished_fade_in = [[CallFunc actionWithTarget:self selector:@selector(finishedFadeIn)] retain];
	start_loading_seq = [[Spawn actions: fadein, finished_fade_in, nil] retain];
	
	
	fadeout = [[FadeOut actionWithDuration:1.0] retain];
	end_callback = [[CallFunc actionWithTarget:self selector:@selector(endOfSequence)] retain];
	end_loading_seq = [[Sequence actions: fadeout, end_callback, nil] retain];
	return self;
}


-(void)finishedFadeIn{
	[run runAction:run_loop_action];
}
-(void)start
{
	[run runAction:start_loading_seq];

	//[self finishedInitialFill];
	
}

-(void)finishedInitialFill{


}

-(void)finishedLoading{
	[run runAction:end_loading_seq];
	[loadingScreen runAction:fadeout];
	
}

-(void)endOfSequence{
	NSLog(@"end of sequence");
	
	moviePlayer = [[jumpaMoviePlayer alloc] init];
	[moviePlayer playMovie];


	
}

-(void)dealloc{
	//NSLog(@"loadingscene : dealloc");
	[runmgr removeAllChildrenWithCleanup:YES];
}

@end 
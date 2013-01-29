//
//  creditsLayer.m
//  Untitled
//
//  Created by harry on 8/09/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "creditsLayer.h"

#define COLLIDER_ARRAY_SIZE 10


@implementation creditsLayer
-(id) init
{
	if( ![super init] )
		return nil;
	//NSLog(@"creditsLayer: init");

	creditsMgr = [[AtlasSpriteManager spriteManagerWithFile:@"PickupCredits.png" capacity:8] retain];
	[self addChild:creditsMgr z:1 tag:1];
	
	oxygensMgr = [[AtlasSpriteManager spriteManagerWithFile:@"PickupOxy.png" capacity:16] retain];
	[self addChild:oxygensMgr z:1 tag:1];
	
	livesMgr = [[AtlasSpriteManager spriteManagerWithFile:@"PickupLife.png" capacity:11] retain];
	[self addChild:livesMgr z:1 tag:1];
	

	return self;
	
}


-(void)reset{
	//NSLog(@"creditsLayer : reset");
	[creditsMgr removeAllChildrenWithCleanup:YES];
	[oxygensMgr removeAllChildrenWithCleanup:YES];
	[livesMgr removeAllChildrenWithCleanup:YES];
	[self setCreditsData:creditscopy oxygens:oxygenscopy lives:livescopy];
}


-(void)resetCredits{
	NSArray *thecredits = [creditsMgr children];
	for(int i=0; i<[thecredits count]; i++){
		[[thecredits objectAtIndex:i] reset];
	}
}

-(void)resetOxygens{
	NSArray *theoxies = [oxygensMgr children];
	for(int i=0; i<[theoxies count]; i++){
		[[theoxies objectAtIndex:i] reset];
	}
}


-(void)setCreditsData:(NSArray*)credits oxygens:(NSArray*)oxygens lives:(NSArray*)lives
{
	
//	creditscopy = [credits retain];
//	oxygenscopy = [oxygens retain];
//	livescopy = [lives retain];

	NSLog(@"maximum number of credits = %d", [credits count]);
	
	[[UIApplication sharedApplication].delegate setMaximumPossibleScore:[NSNumber numberWithInt:[credits count]*5]];
	
	for(int i=0; i<[credits count]; i++){
		NSDictionary *curitem = [credits objectAtIndex:i];
		float xfloat = [[curitem objectForKey:@"x"] floatValue];
		float yfloat = [[curitem objectForKey:@"y"] floatValue];
		[self addCredit:ccp(xfloat, yfloat)];
	}
	for(int i=0; i<[oxygens count]; i++){
		NSDictionary *curitem = [oxygens objectAtIndex:i];
		float xfloat = [[curitem objectForKey:@"x"] floatValue];
		float yfloat = [[curitem objectForKey:@"y"] floatValue];
		[self addOxy:ccp(xfloat, yfloat)];
	}	
	for(int i=0; i<[lives count]; i++){
		NSDictionary *curitem = [lives objectAtIndex:i];
		float xfloat = [[curitem objectForKey:@"x"] floatValue];
		float yfloat = [[curitem objectForKey:@"y"] floatValue];
		[self addLife:ccp(xfloat, yfloat)];
	}

	
}




-(void)addCredit:(CGPoint)location {
	collectable *sprite = [collectable spriteWithRect:CGRectMake(0, 0, 32, 32) spriteManager: creditsMgr];
	AtlasAnimation *animation = [AtlasAnimation animationWithName:@"credit" delay:0.05f];
	
	for(int i=0;i<7;i++) {
		[animation addFrameWithRect: CGRectMake(i*32, 0, 32, 32) ];
	}
	
	[creditsMgr addChild:sprite];
	
	sprite.transformAnchor = ccp(0,0);
	sprite.position = location;
	
	id action = [Animate actionWithAnimation: animation];
	[sprite runAction: [RepeatForever actionWithAction:action ] ];
}

-(void)addOxy:(CGPoint)location {
	collectable *sprite = [collectable spriteWithRect:CGRectMake(0, 0, 40, 40) spriteManager: oxygensMgr];
	AtlasAnimation *animation = [AtlasAnimation animationWithName:@"oxy" delay:0.05f];
	
	for(int i=0;i<15;i++) {
		[animation addFrameWithRect: CGRectMake(i*40, 0, 40, 40) ];
	}
	
	[oxygensMgr addChild:sprite];
	
	sprite.transformAnchor = ccp(0,0);
	sprite.position = location;
	
	id action = [Animate actionWithAnimation: animation];
	[sprite runAction: [RepeatForever actionWithAction:action ] ];
}

-(void)addLife:(CGPoint)location {
	AtlasSprite *sprite = [AtlasSprite spriteWithRect:CGRectMake(0, 0, 32, 32) spriteManager: livesMgr];
	AtlasAnimation *animation = [AtlasAnimation animationWithName:@"lives" delay:0.05f];
	
	for(int i=0;i<9;i++) {
		[animation addFrameWithRect: CGRectMake(i*32, 0, 32, 32) ];
	}
	
	[livesMgr addChild:sprite];
	
	sprite.transformAnchor = ccp(0,0);
	sprite.position = location;
	
	id action = [Animate actionWithAnimation: animation];
	[sprite runAction: [RepeatForever actionWithAction:action ] ];
}



- (void) setOpacity: (GLubyte)newOpacity
{

	NSArray *children = [creditsMgr children];
	for(int i=0;i<[children count];i++){
		[[children objectAtIndex:i] setOpacity:newOpacity];
	}
	
}


 

-(AtlasSpriteManager*)getCreditsMgr{
	return creditsMgr;
}

-(AtlasSpriteManager*)getOxiesMgr{
	return oxygensMgr;
}

-(AtlasSpriteManager*)getLivesMgr{
	return livesMgr;
}
	

@end

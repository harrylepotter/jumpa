//
//  backgroundLayer.m
//  Untitled
//
//  Created by harry on 23/09/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "backgroundLayer.h"
#import "animatedBoundedSprite.h"

@implementation backgroundLayer
@synthesize backgroundNode;
@synthesize cloudsNode;
@synthesize sceneryNode;

-(id) init
{
	if( ![super init] )
		return nil;
	

	
	
	
	Sprite *mushimage;
	
	voidNode = [[CocosNode node] retain];
	backgroundNode = [[CocosNode node] retain];
	cloudsNode = [[CocosNode node] retain];
	sceneryNode = [[CocosNode node] retain];


	
	// Aliased images
	[Texture2D saveTexParameters];
	[Texture2D setAliasTexParameters];
	
	// sky background 
	//staticBackground = [Sprite spriteWithFile:@"sky.png"];
	staticBackground = [Sprite spriteWithPVRTCFile:@"sky.pvr" bpp:4 hasAlpha:YES width:1024];
	// scale the image (optional)
	[staticBackground setPosition:ccp(-170,-170)];
	// change the transform anchor point (optional)
	staticBackground.transformAnchor = ccp(0,0);
	
	[backgroundNode addChild:staticBackground z:-1 parallaxRatio:ccp(0.0f,0.0f)];
	
	
	
	//  clouds 
	clouds = [Layer node];
	
	mushimage = [Sprite spriteWithPVRTCFile:@"cloudfast.pvr" bpp:4 hasAlpha:YES width:1024];
	// scale the image (optional)
	mushimage.scale = 0.5f;
	// change the transform anchor point to 0,0 (optional)
	mushimage.transformAnchor = ccp(0,0);
	// position the image somewhere (optional)
	
	mushimage.position = ccp(60,0);
	// top image is moved at a ratio of 3.0x, 2.5y
	[clouds addChild:mushimage z:1 parallaxRatio:ccp(1.5f,0.6f)];

	
	// NEW CLOUD
	mushimage = [Sprite spriteWithPVRTCFile:@"cloudslow.pvr" bpp:4 hasAlpha:YES width:1024];
	// scale the image (optional)
	mushimage.scale = 0.5f;
	// change the transform anchor point to 0,0 (optional)
	mushimage.transformAnchor = ccp(0,0);
	// position the image somewhere (optional)
	
	mushimage.position = ccp(60,0);
	// top image is moved at a ratio of 3.0x, 2.5y
	[clouds addChild:mushimage];
	
	
	
	
	//[backgroundNode addChild:mushimage];
	//[mushimage setOpacity:128];
	[cloudsNode addChild:clouds];
	clouds.position = ccp(600.0f, 0.0f);
	
	mushroomscenery = [[[silhouettelayer alloc] init] retain];
	mushroomscenery.transformAnchor = ccp(0,0);
	mushroomscenery.position = ccp(-400,0);
	
	
	mushroomscenery2 = [[[silhouettelayer alloc] init] retain];
	mushroomscenery2.transformAnchor = ccp(0,0);
	mushroomscenery2.position = ccp(-400+ 2155,0);
	//[mushroomscenery2 setOpacity:128];





	
	[sceneryNode addChild:mushroomscenery z:2 parallaxRatio:ccp(50.0f,0.6f)];
	[sceneryNode addChild:mushroomscenery2 z:2 parallaxRatio:ccp(50.0f,0.6f)];
	
	[Texture2D restoreTexParameters];
	
	[voidNode addChild:backgroundNode];
	[voidNode addChild:cloudsNode];
	[voidNode addChild:sceneryNode];
	[self addChild:voidNode];
	
	
	float duration = 27.0f;
	backgroundParallaxMovement = [[MoveTo actionWithDuration:duration position:ccp(-600-2155.0f,0.0f)] retain];
	backgroundParallaxMovement2 = [[MoveTo actionWithDuration:duration position:ccp(-600,0.0f)] retain];
	
	
	id cloudParallaxMove = [[MoveTo actionWithDuration:40.0f position:ccp(-500.0f,0.0f)] retain];
	id cloudParallaxMove2 = [[MoveTo actionWithDuration:0.01f position:ccp(600.0f,0.0f)] retain];
	id cloudParallaxRepeat = [[CallFunc actionWithTarget:self selector:@selector(cloudParallax)] retain];
	id cloudParallaxMovementSeq = [[Sequence actions:cloudParallaxMove, cloudParallaxMove2, nil ] retain];
	cloudParallaxMovement = [[RepeatForever actionWithAction:cloudParallaxMovementSeq] retain];

	
	return self;
}

- (void) setOpacity: (GLubyte)newOpacity
{
	NSArray *children;
	//[staticBackground setOpacity:newOpacity];
	
	children = [clouds children];
	for(int i=0;i< [children count];i++){
		Sprite *current = [children objectAtIndex:i];
		[current setOpacity:newOpacity];
	}
	
	children = [mushroomscenery children];
	for(int i=0;i< [children count];i++){
		Sprite *current = [children objectAtIndex:i];
		[current setOpacity:newOpacity];
	}	
	
	[staticBackground setOpacity:newOpacity];
	
}


-(void)runParallax:(NSNumber*)theduration
{
	[self reset];
	float xmovement = 1000.0f;
	//float duration = xmovement / 166.0f;
	float duration = [theduration floatValue];
	
	float cloudsParallaxRatio = 1.0f;
	float mushroomBgParallaxRatio = 5.0f;

		
	
	[self parallaxOdd];
	[self cloudParallax];
	
}

-(void)cloudParallax{
	NSLog(@"cloudParallax");
	[clouds stopAllActions];
	clouds.position = ccp(0,0);
	[clouds runAction:cloudParallaxMovement];
}
						 
-(void)parallaxEven{
	NSLog(@"finished parallax EVEN");
	mushroomscenery.position = ccp(-600+2155.0f,0);
	[mushroomscenery stopAllActions];
	[mushroomscenery2 stopAllActions];
	[mushroomscenery runAction:backgroundParallaxMovement2];
	
	id finishcallback = [CallFunc actionWithTarget:self selector:@selector(parallaxOdd)];
	id seq = [Sequence actions:backgroundParallaxMovement, finishcallback, nil];
	[mushroomscenery2 runAction:seq];
}

-(void)parallaxOdd{
	NSLog(@"finished parallax ODD");
	mushroomscenery2.position = ccp(-600+2155.0f,0);
	[mushroomscenery stopAllActions];
	[mushroomscenery2 stopAllActions];
	[mushroomscenery2 runAction:backgroundParallaxMovement2];
	
	id finishcallback = [CallFunc actionWithTarget:self selector:@selector(parallaxEven)];
	id seq = [Sequence actions:backgroundParallaxMovement, finishcallback, nil];
	[mushroomscenery runAction:seq];
}
						 
							 

-(void)stopParallax{
	[clouds stopAllActions];
	[mushroomscenery stopAllActions];
	[mushroomscenery2 stopAllActions];
}

-(void)reset{
	[clouds setPosition:ccp(0.0,0.0)];
	[mushroomscenery setPosition:ccp(-600.0,0.0)];
	[mushroomscenery2 setPosition:ccp(-600+2155.0f, 0.0)];
}


-(void)setYPosition:(NSNumber*)ypos
{

	float duration = 0.2f;

	[voidNode stopAllActions];
	id enemyParralaxMovement = [MoveTo actionWithDuration:duration position:ccp(0.0f,[ypos floatValue])];
	[voidNode runAction:enemyParralaxMovement];
	
	
}
@end

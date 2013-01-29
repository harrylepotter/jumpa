//
//  bloodemitter.m
//  Untitled
//
//  Created by harry on 7/09/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "starEmitter.h"
enum {
	kTagLabelAtlas = 1,
	kTagEmitter	= 2,
};

@implementation particleStar


+(particleStar*) makeWithPosition:(CGRect)pos totalParticles:(int)p {	
	//NSLog(@"particleStar: makeWithPosition");
	self = [super init];
	return self;
}

-(id) init
{
	return [self initWithTotalParticles:3];
}

-(id) initWithTotalParticles:(int)p
{
	if( !(self=[super initWithTotalParticles:p]) )
		return nil;
	
	// duration
	duration = 0.4f;
	
	// gravity
	gravity.x = -600;
	gravity.y = 100;
	
	// angle
	angle = -0;
	angleVar = 45;
	
	// speed of particles
	speed = 80;
	speedVar = 10;
	
	// radial
	radialAccel = -60;
	radialAccelVar = 0;
	
	// tagential
	tangentialAccel = 15;
	tangentialAccelVar = 0;
	
	// emitter position
	//position.x = 160;
	//position.y = 240;
	posVar.x = 0;
	posVar.y = 0;
	
	// life of particles
	life = 1;
	lifeVar = 0.5;
	
	// size, in pixels
	size = 5.0f;
	sizeVar = 3.0f;
	
	// emits per second
	//emissionRate = totalParticles/life;
	emissionRate = 20.0f;
	
	// color of particles
	startColor.r = 1.00f;
	startColor.g = 1.00f;
	startColor.b = 1.00f;
	startColor.a = 1.0f;
	startColorVar.r = 0.0f;
	startColorVar.g = 0.0f;
	startColorVar.b = 0.0f;
	startColorVar.a = 0.5f;
	endColor.r = 0.0f;
	endColor.g = 0.0f;
	endColor.b = 0.0f;
	endColor.a = 1.0f;
	endColorVar.r = 0.0f;
	endColorVar.g = 0.0f;
	endColorVar.b = 0.0f;
	endColorVar.a = 0.0f;
	
	//self.texture = [[TextureMgr sharedTextureMgr] addImage: @"fire.png"];
	
	// additive
	blendAdditive = YES;
	
	
	return self;
	
	
}


@implementation bigParticleStar


+(particleStar*) makeWithPosition:(CGRect)pos totalParticles:(int)p {	
	//NSLog(@"particleStar: makeWithPosition");
	self = [super init];
	return self;
}

-(id) init
{
	return [self initWithTotalParticles:3];
}

-(id) initWithTotalParticles:(int)p
{
	if( !(self=[super initWithTotalParticles:p]) )
		return nil;
	
	// duration
	duration = 0.8f;
	
	// gravity
	gravity.x = 400;
	gravity.y = -500;
	
	// angle
	angle = -0;
	angleVar = 60;
	
	// speed of particles
	speed = 70;
	speedVar = 20;
	
	// radial
	radialAccel = 0;
	radialAccelVar = 0;
	
	// tagential
	tangentialAccel = 0;
	tangentialAccelVar = 0;
	
	// emitter position
	//position.x = 160;
	//position.y = 240;
	posVar.x = 50;
	posVar.y = 10;
	
	// life of particles
	life = 1;
	lifeVar = 0.5;
	
	// size, in pixels
	size = 20.0f;
	sizeVar = 9.0f;
	
	// emits per second
	//emissionRate = totalParticles/life;
	emissionRate = 10.0f;
	
	// color of particles
	startColor.r = 1.00f;
	startColor.g = 1.00f;
	startColor.b = 1.00f;
	startColor.a = 1.0f;
	startColorVar.r = 0.0f;
	startColorVar.g = 0.0f;
	startColorVar.b = 0.0f;
	startColorVar.a = 0.5f;
	endColor.r = 0.0f;
	endColor.g = 0.0f;
	endColor.b = 0.0f;
	endColor.a = 1.0f;
	endColorVar.r = 0.0f;
	endColorVar.g = 0.0f;
	endColorVar.b = 0.0f;
	endColorVar.a = 0.0f;
	
	//self.texture = [[TextureMgr sharedTextureMgr] addImage: @"fire.png"];
	
	// additive
	blendAdditive = YES;
	
	
	return self;
	
	
}



- (void) setOpacity: (GLubyte)newOpacity
{
	return;
}

@end


@implementation starEmitter
-(id) init
{
	if( (self=[super init]) ) {
		
		//isTouchEnabled = YES;
		
		CGSize s = [[Director sharedDirector] winSize];
		
		//[self schedule:@selector(step:)];
	}
	
	return self;
}
-(void) onEnter
{
	[super onEnter];
	
	ParticleSystem *emitter = [particleStar node];
	[self addChild: emitter z:0 tag:kTagEmitter];
	
	emitter.texture = [[TextureMgr sharedTextureMgr] addImage: @"superstars.png"];
	
}





-(void) restartCallback: (id) sender
{
	
	ParticleSystem *emitter = (ParticleSystem*) [self getChildByTag:kTagEmitter];
	[emitter resetSystem];
	//	[emitter stopSystem];
}

- (void) setOpacity: (GLubyte)newOpacity
{
	return;
}


@end

//
//  bloodemitter.m
//  Untitled
//
//  Created by harry on 7/09/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "bloodemitter.h"
enum {
	kTagLabelAtlas = 1,
	kTagEmitter	= 2,
};

@implementation ParticleBlood



-(id) init
{
	return [self initWithTotalParticles:50];
}

-(id) initWithTotalParticles:(int)p
{
	if( !(self=[super initWithTotalParticles:p]) )
		return nil;
	
	// duration
	duration = 1000.1f;
	
	// gravity
	gravity.x = -100;
	gravity.y = 100;
	
	// angle
	angle = 90;
	angleVar = 360;
	
	// speed of particles
	speed = 90;
	speedVar = 40;
	
	// radial
	radialAccel = 10;
	radialAccelVar = 5;
	
	// tagential
	tangentialAccel = 0;
	tangentialAccelVar = 0;
	
	// emitter position
	position.x = 0;
	position.y = 0;
	posVar.x = 1;
	posVar.y = 2;
	
	// life of particles
	life = 1.0f;
	lifeVar = 0.1f;
	
	// size, in pixels
	size = 4.0f;
	sizeVar = 3.5f;
	
	// emits per second
	//emissionRate = totalParticles/duration;
	//emissionRate = totalParticles/1.1f;
	emissionRate = 30.0f;
	// color of particles
	startColor.r = 0.7f;
	startColor.g = 0.1f;
	startColor.b = 0.2f;
	startColor.a = 0.7f;
	startColorVar.r = 0.2f;
	startColorVar.g = 0.0f;
	startColorVar.b = 0.0f;
	startColorVar.a = 0.0f;
	endColor.r = 0.9f;
	endColor.g = 0.0f;
	endColor.b = 0.0f;
	endColor.a = 0.0f;
	endColorVar.r = 0.5f;
	endColorVar.g = 0.5f;
	endColorVar.b = 0.5f;
	endColorVar.a = 0.0f;
	
	self.texture = [[TextureMgr sharedTextureMgr] addImage: @"superstars.png"];
	
	// additive
	blendAdditive = NO;
	
	return self;

	
}
@end


@implementation bloodEmitter
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

	ParticleSystem *emitter = [ParticleBlood node];
	[self addChild: emitter z:0 tag:kTagEmitter];
	
	emitter.texture = [[TextureMgr sharedTextureMgr] addImage: @"stars.png"];
	
}





-(void) restartCallback: (id) sender
{
	
	ParticleSystem *emitter = (ParticleSystem*) [self getChildByTag:kTagEmitter];
	[emitter resetSystem];
	//	[emitter stopSystem];
}


@end

//
//  LevelFinishedOverlay.m
//  jumpa
//
//  Created by harry on 31/03/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "LevelFinishedOverlay.h"


@implementation LevelFinishedOverlay
-(id)init{
	self = [super init];
	topPart = [[Sprite spriteWithFile:@"levelfinished_layer3.png"] retain];
	topPart.position = ccp(494.0, 232.0);
	topPart.transformAnchor = ccp(0,0);
	[self addChild:topPart];

	
	topPartText = [[Sprite spriteWithFile:@"levelfinished_layer2.png"] retain];
	topPartText.position = ccp(-355.0, 248.0);
	topPartText.transformAnchor = ccp(0,0);
	[self addChild:topPartText];
	
	
	topPartOverlay = [[Sprite spriteWithFile:@"levelfinished_layer1.png"] retain];
	topPartOverlay.position = ccp(480.0, 232.0);
	topPartOverlay.transformAnchor = ccp(0,0);
	[self addChild:topPartOverlay];
	return self;
	
	
}

-(void)startAnimation{
	CGPoint testpos = [topPart convertToWorldSpace:CGPointZero];
	//NSLog(@"testSTARTANIM: %f, %f", testpos.x, testpos.y);
	//NSLog(@"testSTARTANIM2: %f, %f", topPart.position.x, topPart.position.y);
	[topPart runAction:[self topSlideIn:topPart.position]];
	[topPartText runAction:[self topTextSlideIn:topPartText.position]];
	[topPartOverlay runAction:[self topSlideIn:topPartOverlay.position]];
}

-(id)topSlideIn: (CGPoint)fromPosition 
{
	//NSLog(@"top slide in from %f, %f", fromPosition.x, fromPosition.y);
	
	id frame0_16 = [DelayTime actionWithDuration:0.64];
	id frame16_21 = [MoveTo actionWithDuration:0.2 position:ccp(fromPosition.x-352.0,fromPosition.y)];
	id frame21_23 = [MoveTo actionWithDuration:0.08 position:ccp(fromPosition.x-492.3,fromPosition.y)];
	id frame23_25 = [MoveTo actionWithDuration:0.08 position:ccp(fromPosition.x-495.9,fromPosition.y)];
	id frame25_27 = [MoveTo actionWithDuration:0.08 position:ccp(fromPosition.x-492.3,fromPosition.y)];
	id frame27_60 = [DelayTime actionWithDuration:1.32];
	id frame60_62 = [MoveTo actionWithDuration:0.08 position:ccp(fromPosition.x-495.9,fromPosition.y)];
	id frame62_64 = [MoveTo actionWithDuration:0.08 position:ccp(fromPosition.x-489.5,fromPosition.y)];
	id frame64_71 = [MoveTo actionWithDuration:0.28 position:ccp(fromPosition.x,fromPosition.y)];
	id seq = [Sequence actions: frame0_16, frame16_21, frame21_23, frame23_25, frame25_27, frame27_60, frame60_62, frame62_64, frame64_71, nil];
	return seq;
}

-(id)topTextSlideIn: (CGPoint)fromPosition 
{
	//NSLog(@"top slide in from %f, %f", fromPosition.x, fromPosition.y);
	
	id frame0_16 =  [DelayTime actionWithDuration:0.64];
	id frame16_21= [MoveTo actionWithDuration:0.2 position:ccp(fromPosition.x+302.8,fromPosition.y)];
	id frame21_23= [MoveTo actionWithDuration:0.08 position:ccp(fromPosition.x+424.0,fromPosition.y)];
	id frame23_25= [MoveTo actionWithDuration:0.08 position:ccp(fromPosition.x+431.2,fromPosition.y)];
	id frame25_27= [MoveTo actionWithDuration:0.08 position:ccp(fromPosition.x+424.0,fromPosition.y)];
	id frame27_60= [DelayTime actionWithDuration:1.32];
	id frame60_61= [MoveTo actionWithDuration:0.04 position:ccp(fromPosition.x+427.6,fromPosition.y)];
	id frame61_64= [MoveTo actionWithDuration:0.12 position:ccp(fromPosition.x+424.0,fromPosition.y)];
	id frame64_71= [MoveTo actionWithDuration:0.28 position:ccp(fromPosition.x,fromPosition.y)];
	id seq = [Sequence actions: frame0_16, frame16_21, frame21_23, frame23_25, frame25_27, frame27_60, frame60_61, frame61_64,frame64_71, nil];
	return seq;
	
}



@end

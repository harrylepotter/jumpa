//
//  MediumMushroomEnemy.m
//  jumpa
//
//  Created by harry on 29/10/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "WingedMushroomEnemy.h"


@implementation WingedMushroomEnemy




+(WingedMushroomEnemy*) make {	
	
	// TEST CODE
	self = [super makeWithFile:@"wingshroom.png" frameSize:CGRectMake(0, 0, 140, 100) delay:[NSNumber numberWithFloat:0.06f]];
	//1: (14,9) , (69,52)
	CGRect frame1bound = CGRectMake(41.0, 44.0, 39.0, 36.0);

	
	[self addFrame: CGRectMake(0*140, 0*100, 140, 100) bounds:frame1bound ]; 
	[self addFrame: CGRectMake(1*140, 0*100, 140, 100) bounds:frame1bound ]; 
	[self addFrame: CGRectMake(2*140, 0*100, 140, 100) bounds:frame1bound ]; 
	[self addFrame: CGRectMake(3*140, 0*100, 140, 100) bounds:frame1bound ]; 
	[self addFrame: CGRectMake(0*140, 1*100, 140, 100) bounds:frame1bound ]; 
	[self addFrame: CGRectMake(1*140, 1*100, 140, 100) bounds:frame1bound ]; 
	[self addFrame: CGRectMake(2*140, 1*100, 140, 100) bounds:frame1bound ]; 
	[self addFrame: CGRectMake(3*140, 1*100, 140, 100) bounds:frame1bound ]; 
	[self addFrame: CGRectMake(0*140, 2*100, 140, 100) bounds:frame1bound ]; 
	[self addFrame: CGRectMake(1*140, 2*100, 140, 100) bounds:frame1bound ]; 
	[self addFrame: CGRectMake(2*140, 2*100, 140, 100) bounds:frame1bound ]; 
	[self addFrame: CGRectMake(3*140, 2*100, 140, 100) bounds:frame1bound ]; 
	[self addFrame: CGRectMake(0*140, 3*100, 140, 100) bounds:frame1bound ]; 
	[self addFrame: CGRectMake(1*140, 3*100, 140, 100) bounds:frame1bound ]; 
	[self addFrame: CGRectMake(2*140, 3*100, 140, 100) bounds:frame1bound ]; 
	[self addFrame: CGRectMake(3*140, 3*100, 140, 100) bounds:frame1bound ]; 
	
	//test.position = ccp(150, 99);
	//[self addChild:test];
	[self playAnimation:YES];
	
	
	//[[SFXManager sharedSoundManager] addSound:@"shroom2" gain:1.0f];
	
	
	// TEST CODE 
	
	return self;
}




@end

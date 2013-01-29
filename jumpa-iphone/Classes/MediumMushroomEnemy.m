//
//  MediumMushroomEnemy.m
//  jumpa
//
//  Created by harry on 29/10/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "MediumMushroomEnemy.h"


@implementation MediumMushroomEnemy




+(MediumMushroomEnemy*) make {	
	//self = [super makeWithFile:@"Shroom2.png" bounds:CGRectMake(30.0f, 0.0f, 39.0f, 133.0f)];
	// TEST CODE
	self = [super makeWithFile:@"Shroom2Short.png" frameSize:CGRectMake(30.0, 0, 130, 200) delay:[NSNumber numberWithFloat:0.06f]];
	//1: (14,9) , (69,52)
	CGRect frame1bound = CGRectMake(30.0, 0.0, 39.0, 133.0);
	//2: (16,16) , (64,45)
	CGRect frame2bound = CGRectMake(30.0, 0.0, 39.0, 133.0);
	//3: (33,16), (34,91)
	CGRect frame3bound = CGRectMake(30.0, 0.0, 39.0, 133.0);
	//4: (33,47), (34, 91)
	CGRect frame4bound = CGRectMake(30.0, 0.0, 39.0, 133.0);

	[self addFrame: CGRectMake(0, 0, 130, 200) bounds:frame1bound ]; // A 
	[self addFrame: CGRectMake(0, 0, 130, 200) bounds:frame1bound ]; // A 
	[self addFrame: CGRectMake(0, 0, 130, 200) bounds:frame1bound ]; // A 

	[self addFrame: CGRectMake(0, 0, 130, 200) bounds:frame1bound ]; // A 
	[self addFrame: CGRectMake(0, 0, 130, 200) bounds:frame1bound ]; // A 
	[self addFrame: CGRectMake(0, 0, 130, 200) bounds:frame1bound ]; // A 
	
	[self addFrame: CGRectMake(0, 0, 130, 200) bounds:frame1bound ]; // A 
	[self addFrame: CGRectMake(0, 0, 130, 200) bounds:frame1bound ]; // A 
	[self addFrame: CGRectMake(0, 0, 130, 200) bounds:frame1bound ]; // A 
	
	
	[self addFrame: CGRectMake(130, 0, 130, 200) bounds:frame2bound ]; // B
	[self addFrame: CGRectMake(130, 0, 130, 200) bounds:frame2bound ]; // B

	
	[self addFrame: CGRectMake(260, 0, 130, 200) bounds:frame3bound ]; // C 
	[self addFrame: CGRectMake(260, 0, 130, 200) bounds:frame3bound ]; // C 
	
	[self addFrame: CGRectMake(390, 0, 130, 200) bounds:frame4bound ]; // D
	[self addFrame: CGRectMake(390, 0, 130, 200) bounds:frame4bound ]; // D
	[self addFrame: CGRectMake(390, 0, 130, 200) bounds:frame4bound ]; // D
	[self addFrame: CGRectMake(390, 0, 130, 200) bounds:frame4bound ]; // D
	[self addFrame: CGRectMake(390, 0, 130, 200) bounds:frame4bound ]; // D
	[self addFrame: CGRectMake(390, 0, 130, 200) bounds:frame4bound ]; // D
	
	[self addFrame: CGRectMake(390, 0, 130, 200) bounds:frame4bound ]; // D
	[self addFrame: CGRectMake(390, 0, 130, 200) bounds:frame4bound ]; // D
	[self addFrame: CGRectMake(390, 0, 130, 200) bounds:frame4bound ]; // D
	[self addFrame: CGRectMake(390, 0, 130, 200) bounds:frame4bound ]; // D
	[self addFrame: CGRectMake(390, 0, 130, 200) bounds:frame4bound ]; // D
	[self addFrame: CGRectMake(390, 0, 130, 200) bounds:frame4bound ]; // D
	
	
	[self addFrame: CGRectMake(260, 0, 130, 200) bounds:frame3bound ]; // C 
	[self addFrame: CGRectMake(260, 0, 130, 200) bounds:frame3bound ]; // C 
	
	[self addFrame: CGRectMake(130, 0, 130, 200) bounds:frame2bound ]; // B
	[self addFrame: CGRectMake(130, 0, 130, 200) bounds:frame2bound ]; // B

	
	[self addFrame: CGRectMake(0, 0, 130, 200) bounds:frame1bound ]; // A 
	[self addFrame: CGRectMake(0, 0, 130, 200) bounds:frame1bound ]; // A 
	[self addFrame: CGRectMake(0, 0, 130, 200) bounds:frame1bound ]; // A 
	

	//test.position = ccp(150, 99);
	//[self addChild:test];
	[self playAnimation:YES];
	
	
	//[[SFXManager sharedSoundManager] addSound:@"shroom2" gain:1.0f];

	
	// TEST CODE 
	
	return self;
}




@end

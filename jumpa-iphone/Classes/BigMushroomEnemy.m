//
//  BigMushroomEnemy.m
//  Untitled
//
//  Created by Harry Potter on 19/08/09.
//  Copyright 2009 Synthesia. All rights reserved.
//

#import "BigMushroomEnemy.h"


@implementation BigMushroomEnemy
+(BigMushroomEnemy*) make {	
	//self = [super makeWithFile:@"Shroom3Still.png" bounds:CGRectMake(30.0f, 0.0f, 39.0f, 133.0f)];
	self = [super makeWithFile:@"Shroom3Short.png" frameSize:CGRectMake(0, 0, 146, 246) delay:[NSNumber numberWithFloat:0.06f]];
	

	CGRect frame1bound = CGRectMake(46.0, 0.0, 66.0, 158.0); // medium
	CGRect frame2bound = CGRectMake(46.0, 0.0, 66.0, 158.0); // medium
	CGRect frame3bound = CGRectMake(49.0, 0.0, 74.0, 119.0); // short
	CGRect frame4bound = CGRectMake(49.0, 0.0, 74.0, 119.0); // short
	CGRect frame5bound = CGRectMake(40.0, 0.0, 75.0, 208.0); // tall
	CGRect frame6bound = CGRectMake(40.0, 0.0, 75.0, 208.0); // tall
	CGRect frame7bound = frame2bound;
	CGRect frame8bound = frame1bound;
	
	CGRect frame1frame = CGRectMake(0, 0, 146, 246);
	CGRect frame2frame = CGRectMake(146, 0, 146, 246);
	CGRect frame3frame = CGRectMake(292, 0, 146, 246);
	CGRect frame4frame = CGRectMake(438, 0, 146, 246);
	CGRect frame5frame = CGRectMake(584, 0, 146, 246);
	CGRect frame6frame = CGRectMake(730, 0, 146, 246);
	CGRect frame7frame = frame2frame;
	CGRect frame8frame = frame1frame;
	
	for(int i=0; i<12;i++){
		[self addFrame:frame1frame bounds:frame1bound];
	}
	
	[self addFrame:frame2frame bounds:frame2bound];
	
	for(int i=0; i<8;i++){
		[self addFrame:frame3frame bounds:frame3bound];
	}	
	
	for(int i=0; i<2;i++){
		[self addFrame:frame4frame bounds:frame4bound];
	}
	
	for(int i=0; i<2;i++){
		[self addFrame:frame5frame bounds:frame5bound];
	}
	
	for(int i=0; i<8;i++){
		[self addFrame:frame6frame bounds:frame6bound];
	}
	
	for(int i=0; i<2;i++){
		[self addFrame:frame1frame bounds:frame1bound];
	}
	
	for(int i=0; i<2;i++){
		[self addFrame:frame2frame bounds:frame2bound];
	}
	
	[self playAnimation:YES];
	
	return self;
}
@end



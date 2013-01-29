//
//  SmallMushroomEnemy.m
//  jumpa
//
//  Created by harry on 29/10/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "SmallMushroomEnemy.h"



@implementation SmallMushroomEnemy




+(SmallMushroomEnemy*) make {	
	//self = [super makeWithFile:@"Shroom1.png" bounds:CGRectMake(25.0f, 0.0f, 34.0f, 55.0f)];
	self = [super makeWithFile:@"Shroom1.png" bounds:CGRectMake(25.0f, 0.0f, 34.0f, 55.0f)];
	
	return self;
}


@end


//
//  collectable.m
//  jumpa
//
//  Created by harry on 15/06/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "collectable.h"


@implementation collectable

+(collectable*)spriteWithRect:(CGRect)rect spriteManager:(AtlasSpriteManager *)manager{
	self = [super spriteWithRect:rect spriteManager:manager];
	isCollectable = YES;
}
-(void)collect{
	[self setVisible:NO];
	isCollectable = NO;
}

-(BOOL)getIsCollectable{
	return isCollectable;
}

-(void)reset{
	[self setVisible:YES];
	isCollectable = YES;
}


@end

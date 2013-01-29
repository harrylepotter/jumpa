//
//  easymenuitem.m
//  menu
//
//  Created by harry on 20/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "easymenuitem.h"


@implementation easymenuitem

-(id)init{
	self = [super init];
	return self;
}

-(void)setupAssets{
	NSLog(@"easymenuitem: setupassets");
	mgr = [[AtlasSpriteManager spriteManagerWithFile:@"easy_menuitem.png" capacity:5] retain];
	
	
	locked = [[AtlasSprite spriteWithRect:CGRectMake(0, 0, 98, 49) spriteManager: mgr] retain];
	locked.transformAnchor = ccp(0,0);
	unlocked = [[AtlasSprite spriteWithRect:CGRectMake(0, 49, 98, 49) spriteManager: mgr] retain];
	unlocked.transformAnchor = ccp(0,0);
	unlocked_pressed = [[AtlasSprite spriteWithRect:CGRectMake(0, 97, 98, 49) spriteManager: mgr] retain];
	unlocked_pressed.transformAnchor = ccp(0,0);
	unlocked_won_pressed = [[AtlasSprite spriteWithRect:CGRectMake(0, 144, 98, 49) spriteManager: mgr] retain];
	unlocked_won_pressed.transformAnchor = ccp(0,0);
	unlocked_won = [[AtlasSprite spriteWithRect:CGRectMake(0, 194, 98, 49) spriteManager: mgr] retain];
	unlocked_won.transformAnchor = ccp(0,0);
}




@end

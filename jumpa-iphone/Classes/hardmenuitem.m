//
//  hardmenuitem.m
//  menu
//
//  Created by harry on 20/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "hardmenuitem.h"


@implementation hardmenuitem

-(id)init{
	self = [super init];
	return self;
}

-(void)setupAssets{
	NSLog(@"hardmenuitem: setupassets");
	mgr = [[AtlasSpriteManager spriteManagerWithFile:@"hard_menuitem.png" capacity:5] retain];
	
	
	locked = [[AtlasSprite spriteWithRect:CGRectMake(0, 0, 101, 71) spriteManager: mgr] retain];
	locked.transformAnchor = ccp(0,0);
	unlocked = [[AtlasSprite spriteWithRect:CGRectMake(0, 71, 101, 71) spriteManager: mgr] retain];
	unlocked.transformAnchor = ccp(0,0);
	unlocked_pressed = [[AtlasSprite spriteWithRect:CGRectMake(0, 141, 101, 71) spriteManager: mgr] retain];
	unlocked_pressed.transformAnchor = ccp(0,0);
	unlocked_won_pressed = [[AtlasSprite spriteWithRect:CGRectMake(0, 212, 101, 71) spriteManager: mgr] retain];
	unlocked_won_pressed.transformAnchor = ccp(0,0);
	unlocked_won = [[AtlasSprite spriteWithRect:CGRectMake(0, 282, 101, 71) spriteManager: mgr] retain];
	unlocked_won.transformAnchor = ccp(0,0);
}

@end

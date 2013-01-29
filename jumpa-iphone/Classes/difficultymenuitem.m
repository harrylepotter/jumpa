//
//  difficultymenuitem.m
//  menu
//
//  Created by harry on 15/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "difficultymenuitem.h"
#import "constants.h"

@implementation difficultymenuitem

-(id)init{
	self = [super init];
	
	//AtlasSprite *menuImage = [Sprite spriteWithFile:@"medium_menuitem.png"];
	
	[self setupAssets];
	
	state_sprites = [[NSArray arrayWithObjects:locked, unlocked, unlocked_pressed, unlocked_won_pressed, unlocked_won, nil] retain];
	
	[mgr addChild:locked];
	[mgr addChild:unlocked];
	[mgr addChild:unlocked_pressed];
	[mgr addChild:unlocked_won_pressed];
	[mgr addChild:unlocked_won];


	[self addChild:mgr];

	
	
	[self setButtonState:STATE_LOCKED];
	

	
	return self;
	
}


-(void)setupAssets{
	NSLog(@"difficultymenuitem: setupassets");
	mgr = [[AtlasSpriteManager spriteManagerWithFile:@"medium_menuitem.png" capacity:5] retain];
	
	
	locked = [[AtlasSprite spriteWithRect:CGRectMake(0, 0, 101, 56) spriteManager: mgr] retain];
	locked.transformAnchor = ccp(0,0);
	unlocked = [[AtlasSprite spriteWithRect:CGRectMake(0, 56, 101, 56) spriteManager: mgr] retain];
	unlocked.transformAnchor = ccp(0,0);
	unlocked_pressed = [[AtlasSprite spriteWithRect:CGRectMake(0, 110, 101, 56) spriteManager: mgr] retain];
	unlocked_pressed.transformAnchor = ccp(0,0);
	unlocked_won_pressed = [[AtlasSprite spriteWithRect:CGRectMake(0, 165, 101, 56) spriteManager: mgr] retain];
	unlocked_won_pressed.transformAnchor = ccp(0,0);
	unlocked_won = [[AtlasSprite spriteWithRect:CGRectMake(0, 220, 101, 56) spriteManager: mgr] retain];
	unlocked_won.transformAnchor = ccp(0,0);
}



-(int)getButtonState{
	return button_state;
}

-(void)setButtonState:(int)state{
	
	AtlasSprite *sprite_to_show;
	button_state = state;
	switch (state) {
		case STATE_LOCKED:
			sprite_to_show = locked;
			break;
		case STATE_UNLOCKED:
			sprite_to_show = unlocked;
			break;
		case STATE_UNLOCKED_PRESSED:
			sprite_to_show = unlocked_pressed;
			break;
		case STATE_UNLOCKED_WON_PRESSED:
			sprite_to_show = unlocked_won_pressed;
			break;
		case STATE_UNLOCKED_WON:
			sprite_to_show = unlocked_won;
			break;
		default:
			sprite_to_show = unlocked;
			break;
	}
	
	for(int i=0; i< [state_sprites count]; i++){
		AtlasSprite *current_sprite = [state_sprites objectAtIndex:i];
		if(current_sprite != sprite_to_show){
			[current_sprite setVisible:0];
		}else {
			[current_sprite setVisible:1];
			present_sprite = current_sprite;
		}

	
	}

}

-(CGSize)contentSize{
	return [present_sprite contentSize];
}


@end

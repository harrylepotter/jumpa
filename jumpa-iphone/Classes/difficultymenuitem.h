//
//  difficultymenuitem.h
//  menu
//
//  Created by harry on 15/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"



@interface difficultymenuitem : Layer {
	AtlasSpriteManager *mgr;
	AtlasSprite *locked;
	AtlasSprite *unlocked;
	AtlasSprite *unlocked_pressed;
	AtlasSprite *unlocked_won_pressed;
	AtlasSprite *unlocked_won;
	
	NSArray *state_sprites;
	AtlasSprite *present_sprite;
	
	int button_state;

	
}


-(void)setButtonState:(int)state;
-(int)getButtonState;
-(void)setupAssets;
-(CGSize)contentSize;

@end

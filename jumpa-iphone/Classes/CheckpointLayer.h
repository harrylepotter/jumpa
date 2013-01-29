//
//  CheckpointLayer.h
//  jumpa
//
//  Created by harry on 8/03/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "SFXManager.h"

@interface CheckpointLayer : Layer {

	Sprite *checkpointgfx;
	id move;
	id waitabit;
	id move_ease_inout1;
	id move_ease_inout_back;
	id move_ease_inout_fade;
	id move_ease_inout_back1;
	id return_to_original;
	id blinking;
	id seq1;
	SFXManager *sfx;
}

@end

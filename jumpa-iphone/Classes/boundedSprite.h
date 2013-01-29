//
//  boundedSprite.h
//  Untitled
//
//  Created by harry on 2/09/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

#define SPRITE_TYPE_ENEMY 0
#define SPRITE_TYPE_GROUND 1
#define SPRITE_TYPE_PLATFORM 2
#define SPRITE_TYPE_NORMAL 3


@interface boundedSprite : Sprite {
	CGRect charbounds;
	CGPoint initialpos;
	//BEN : TEMP
	NSString *filename;
	int spriteType;
	
}
@property (nonatomic) CGRect charbounds;
@property CGPoint initialpos;
@property int spriteType;

@end

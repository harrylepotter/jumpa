//
//  boundedSprite.h
//  Untitled
//
//  Created by harry on 2/09/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "JumpaAnimation.h"

@interface animatedBoundedSprite : CocosNode {
	CGRect charbounds;
	CGPoint initialpos;
	//BEN : TEMP
	NSString *filename;
	
	AtlasSpriteManager *mgr;
	JumpaSprite *coreSprite;
	JumpaAnimation *animation;
	id animation_action;
	
	
}
@property (nonatomic) CGRect charbounds;
@property CGPoint initialpos;
@property CGPoint position;

@end

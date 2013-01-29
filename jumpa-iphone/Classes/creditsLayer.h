//
//  creditsLayer.h
//  Untitled
//
//  Created by harry on 8/09/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "starEmitter.h"
#import "collectable.h"


@interface creditsLayer : Layer {
	AtlasSpriteManager *creditsMgr;
	AtlasSpriteManager *oxygensMgr;
	AtlasSpriteManager *livesMgr;
	
	NSArray *creditscopy;
	NSArray *oxygenscopy;
	NSArray *livescopy;
	
	NSArray *allCreditsData;
	int dataIndex;
	float curMaxXPosition;

	
}

@end

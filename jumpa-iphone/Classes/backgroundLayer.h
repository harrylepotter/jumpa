//
//  backgroundLayer.h
//  Untitled
//
//  Created by harry on 23/09/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "silhouettelayer.h"

@interface backgroundLayer : Layer {
	CocosNode *voidNode;
	Sprite *staticBackground;
	Sprite *clouds;
	Layer *mushroomscenery;
	Layer *mushroomscenery2;
	
	CocosNode *backgroundNode;
	CocosNode *cloudsNode;
	CocosNode *sceneryNode;
	
	id backgroundParallaxMovement;
	id backgroundParallaxMovement2;
	
	id cloudParallaxMovement;
}
@property (nonatomic, retain) CocosNode *backgroundNode;
@property (nonatomic, retain) CocosNode *cloudsNode;
@property (nonatomic, retain) CocosNode *sceneryNode;

@end
